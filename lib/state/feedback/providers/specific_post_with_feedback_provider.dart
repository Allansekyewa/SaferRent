import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/feedback/extensions/feedback_sorting_by_request.dart';
import 'package:saferent/state/feedback/models/feedback.dart';
import 'package:saferent/state/feedback/models/post_feedback_request.dart';
import 'package:saferent/state/feedback/models/posts_with_feedback.dart';
import 'package:saferent/state/posts/models/post.dart';

// Define a Riverpod StreamProvider for specific post with feedback
final specificPostWithFeedbackProvider = StreamProvider.family
    .autoDispose<PostWithFeedback, RequestsForPostAndFeedback>((ref, request) {
  // Create a StreamController to manage the stream of PostWithFeedback
  final controller = StreamController<PostWithFeedback>();
  // Variables to hold post and feedbacks data
  Post? post;
  Iterable<FeedBack>? feedbacks;

  // Function to notify the stream when there are changes
  void notify() {
    final localPost = post;
    if (localPost == null) {
      return;
    }
    final outputFeedbacks = (feedbacks ?? []).applySortingFrom(request);
    final result =
        PostWithFeedback(post: localPost, feedbacks: outputFeedbacks);
    controller.sink.add(result);
  }

  // Listen to changes in the posts collection for the specified postId
  final postSub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .where(
        FieldPath.documentId,
        isEqualTo: request.postId,
      )
      .limit(1)
      .snapshots()
      .listen((snapshot) {
    if (snapshot.docs.isEmpty) {
      // If no document is found for the specified postId, set post and feedbacks to null
      post = null;
      feedbacks = null;
      notify();
      return;
    }
    final doc = snapshot.docs.first;
    if (doc.metadata.hasPendingWrites) {
      // Ignore changes that are still pending
      return;
    }
    // Create a Post object from the document data
    post = Post(
      postId: doc.id,
      json: doc.data(),
    );
    notify();
  });

  // Query for feedbacks related to the specified postId, ordered by createdAt in descending order
  final feedbackQuery = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.feedback)
      .where(FirebaseFieldNames.postId, isEqualTo: request.postId)
      .orderBy(FirebaseFieldNames.createdAt, descending: true);

  // Apply limit to the feedback query if specified in the request
  final limitedFeedbacksQuery = request.limit != null
      ? feedbackQuery.limit(request.limit!)
      : feedbackQuery;

  // Listen to changes in the feedbacks collection
  final feedbackSub = limitedFeedbacksQuery.snapshots().listen((snapshot) {
    // Filter out documents with pending writes and create a list of FeedBack objects
    feedbacks = snapshot.docs
        .where((doc) => !doc.metadata.hasPendingWrites)
        .map((doc) => FeedBack(id: doc.id, doc.data()))
        .toList();
    notify();
  });

  // Add a cleanup function to cancel the subscriptions and close the controller when the provider is disposed
  ref.onDispose(() {
    postSub.cancel();
    feedbackSub.cancel();
    controller.close();
  });

  // Return the stream from the controller
  return controller.stream;
});

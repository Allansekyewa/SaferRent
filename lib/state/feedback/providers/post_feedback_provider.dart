import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/feedback/extensions/feedback_sorting_by_request.dart';
import 'package:saferent/state/feedback/models/feedback.dart';
import 'package:saferent/state/feedback/models/post_feedback_request.dart';

final postFeedbackProvider = StreamProvider.family
    .autoDispose<Iterable<FeedBack>, RequestsForPostAndFeedback>(
  (ref, RequestsForPostAndFeedback request) {
    final controller = StreamController<Iterable<FeedBack>>();
    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.feedback)
        .where(FirebaseFieldNames.postId, isEqualTo: request.postId)
        .snapshots()
        .listen(
      (snapshot) {
        final documents = snapshot.docs;
        final limitedDocuments =
            request.limit != null ? documents.take(request.limit!) : documents;
        final feedback = limitedDocuments
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map((document) => FeedBack(document.data(), id: document.id));
        final result = feedback.applySortingFrom(request);
        controller.sink.add(result);
      },
    );
    ref.onDispose(
      () {
        sub.cancel();
        controller.close();
      },
    );
    return controller.stream;
  },
);

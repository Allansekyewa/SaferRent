import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/posts/models/post.dart';

// Define a Riverpod provider for a stream of posts
final allPostsProvider = StreamProvider.autoDispose<Iterable<Post>>(
  (ref) {
    // Create a StreamController to manage the stream
    final controller = StreamController<Iterable<Post>>();

    // Set up a listener on the "posts" collection in Firestore
    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.posts,
        )

        ///TODO there was an orderby querry here that had to order posts by descending order
        ///it was preventing the ui to render posts
        ///will come back after in future
        .snapshots()
        .listen(
      (snapshots) {
        // Convert the document snapshots to Post objects and add them to the stream
        final posts = snapshots.docs.map(
          (doc) => Post(
            postId: doc.id,
            json: doc.data(),
          ),
        );

        controller.sink.add(posts);
      },
    );

    // Set up cleanup when the provider is disposed
    ref.onDispose(
      () {
        sub.cancel(); // Cancel the Firestore stream subscription
        controller.close(); // Close the StreamController
      },
    );

    // Return the stream from the StreamController
    return controller.stream;
  },
);

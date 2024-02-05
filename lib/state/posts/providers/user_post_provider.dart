import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/auth/providers/user_id_provider.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/posts/models/post.dart';
import 'package:saferent/state/posts/models/post_key.dart';

//Define a riverpod provider for the stream
final userPostsProvider = StreamProvider.autoDispose<Iterable<Post>>(
  (ref) {
    final userId = ref.watch(userIdProvider);
    //Create stream management using stream controller
    final controller = StreamController<Iterable<Post>>();
    controller.onListen = () {
      controller.sink.add([]);
    };
    // setton up a listener posts collection in the cloud firestore
    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.posts)

        ///TODO there was an orderby querry here that had to order posts by descending order
        ///it was preventing the ui to render posts
        ///will come back after in future
        .where(PostKey.userId, isEqualTo: userId)
        .snapshots()
        .listen(
      (snapshot) {
        // change or convert snapshots to posts objects and change them to the sream
        final documents = snapshot.docs;
        final posts = documents
            .where(
              (doc) => !doc.metadata.hasPendingWrites,
            )
            .map(
              (doc) => Post(
                postId: doc.id,
                json: doc.data(),
              ),
            );
        controller.sink.add(posts);
      },
    );
    //disposing off the provder after its been used (clean up)
    ref.onDispose(
      () {
        //cancel firestore subscription
        sub.cancel();
        // close stream controller
        controller.close();
      },
    );
    // returning stream from the stream controller
    return controller.stream;
  },
);

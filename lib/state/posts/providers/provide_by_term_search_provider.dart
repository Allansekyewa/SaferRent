import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/posts/models/post.dart';
import 'package:saferent/state/posts/typedefs/search_term.dart';

final postsBysearchTermProvider =
    StreamProvider.family.autoDispose<Iterable<Post>, SearchTerm>(
  (ref, SearchTerm searchTerm) {
    final controller = StreamController<Iterable<Post>>();
    final sub = FirebaseFirestore.instance
        .collection(FirebaseCollectionName.posts)
        .snapshots()
        .listen(
      (snapshot) {
        final posts = snapshot.docs
            .map(
              (doc) => Post(json: doc.data(), postId: doc.id),
            )
            .where(
              (post) => post.description.toLowerCase().contains(
                    searchTerm.toLowerCase(),
                  ),
            );
        controller.sink.add(posts);
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

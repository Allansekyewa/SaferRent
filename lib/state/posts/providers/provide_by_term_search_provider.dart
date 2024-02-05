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

        ///TODO there was an orderby querry here that had to order posts by descending order
        ///it was preventing the ui to render posts
        ///will come back after in future
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

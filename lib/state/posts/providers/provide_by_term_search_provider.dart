import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/posts/models/post.dart';
import 'package:saferent/state/posts/typedefs/search_term.dart';

final a = StreamProvider.family
    .autoDispose<Iterable<Post>, SearchTerm>((ref, SearchTerm b) {
  final c = StreamController<Iterable<Post>>();
  final d = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .snapshots()
      .listen(
    (snapshot) {
      final e = snapshot.docs
          .map(
        (doc) => Post(json: doc.data(), postId: doc.id),
      )
          .where(
        (post) {
          final f = post.description.toLowerCase().split(' ');
          final g = b.toLowerCase().split(' ');

          return g.every((h) => f.any((i) => i.startsWith(h)));
        },
      );
      c.sink.add(e);
    },
  );
  ref.onDispose(
    () {
      d.cancel();
      c.close();
    },
  );
  return c.stream;
});

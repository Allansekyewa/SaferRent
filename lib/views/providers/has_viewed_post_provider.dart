import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/auth/providers/user_id_provider.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';

final hasViewedPostProvider = StreamProvider.family.autoDispose<bool, PostId>(
  (ref, PostId postId) {
    final userId = ref.watch(userIdProvider);
    if (userId == null) {
      return Stream<bool>.value(false);
    }
    final controller = StreamController<bool>();
    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.views,
        )
        .where(
          FirebaseFieldNames.postId,
          isEqualTo: postId,
        )
        .where(FirebaseFieldNames.userId, isEqualTo: userId)
        .snapshots()
        .listen(
      (snapshot) {
        if (snapshot.docs.isNotEmpty) {
          controller.add(true);
        } else {
          controller.add(false);
        }
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

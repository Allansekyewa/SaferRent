import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/auth/providers/user_id_provider.dart'; // Import the user ID provider

final postSeensCountProvider = StreamProvider.family.autoDispose<int, PostId>(
  (ref, PostId postId) {
    final userId = ref.read(userIdProvider); // Read the user ID
    final controller = StreamController<int>.broadcast();
    controller.onListen = () {
      controller.sink.add(0);
      final sub = FirebaseFirestore.instance
          .collection(FirebaseCollectionName.seens)
          .where(FirebaseFieldNames.postId, isEqualTo: postId)
          .where(FirebaseFieldNames.userId,
              isEqualTo: userId) // Filter by user ID
          .snapshots()
          .listen(
        (snapshot) {
          controller.sink.add(snapshot.docs.length);
        },
      );
      ref.onDispose(
        () {
          sub.cancel();
          controller.close();
        },
      );
    };
    return controller.stream;
  },
);

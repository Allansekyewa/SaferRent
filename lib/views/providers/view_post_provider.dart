import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/viewership/models/viewership.dart';
import 'package:saferent/state/viewership/models/viewership_request.dart';

//viewunview postprovider
final viewedThisPostProvider = FutureProvider.family
    .autoDispose<bool, ViewershipRequest>(
        (ref, ViewershipRequest request) async {
  final query = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.views)
      .where(
        FirebaseFieldNames.postId,
        isEqualTo: request.postId,
      )
      .where(FirebaseFieldNames.userId, isEqualTo: request.viewedby)
      .get();
  final hasViewed = await query.then(
    (snapshot) => snapshot.docs.isNotEmpty,
  );

  if (hasViewed) {
    try {
      await query.then((snapshot) async {
        for (final doc in snapshot.docs) {
          await doc.reference.delete();
        }
      });
      return true;
    } catch (_) {
      return false;
    }
  } else {
    final view = Viewership(
      postId: request.postId,
      viewedby: request.viewedby,
      date: DateTime.now(),
    );
    try {
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.views)
          .add(view);
      return true;
    } catch (_) {
      return false;
    }
  }
});

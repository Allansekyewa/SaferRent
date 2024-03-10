import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:saferent/state/constants/firebase_field_names.dart';
import 'package:saferent/state/seenBy/models/seenBy.dart';
import 'package:saferent/state/seenBy/models/seenBy_request.dart';

final seenThisPostProvider = FutureProvider.family<bool, SeenByRequest>(
    (ref, SeenByRequest request) async {
  try {
    final query = await FirebaseFirestore.instance
        .collection(FirebaseCollectionName.seens)
        .where(FirebaseFieldNames.postId, isEqualTo: request.postId)
        .where(FirebaseFieldNames.userId, isEqualTo: request.seenby)
        .get();

    if (query.docs.isEmpty) {
      final see = SeenBy(
          postId: request.postId, seenby: request.seenby, date: DateTime.now());
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.seens)
          .add(see);
      return true;
    } else {
      return true;
    }
  } catch (_) {
    return false;
  }
});

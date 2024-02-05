import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/shoppingCart/models/cart.dart';

typedef SaveCart = Future<void> Function(Cart cart);

final saveCartProvider = Provider<SaveCart>((ref) {
  final firestore = FirebaseFirestore.instance;
  const cartCollection = 'cart';

  return (Cart cart) async {
    if (cart.userId == null || cart.userId.isEmpty) {
      throw Exception(
          'User ID is null or empty. Please initialize the cart with a valid user ID before saving.');
    }
    await firestore
        .collection(cartCollection)
        .doc(cart.userId)
        .set(cart.toJson());
  };
});

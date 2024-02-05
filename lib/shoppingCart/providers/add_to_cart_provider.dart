import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/shoppingCart/models/cart.dart';
import 'package:saferent/shoppingCart/models/cart_items.dart';

typedef AddToCart = Future<void> Function(
    CartItem item, String userId, String frompostId);

final addToCartProvider = Provider<AddToCart>((ref) {
  final firestore = FirebaseFirestore.instance;
  const cartCollection = 'cart';

  return (CartItem item, String userId, String frompostId) async {
    var doc = await firestore.collection(cartCollection).doc(userId).get();
    var cart = Cart.fromJson(doc.data()!);

    cart = Cart(
      userId: cart.userId,
      items: List.from(cart.items)..add(item),
      frompostId: cart.frompostId,
    );

    await firestore.collection(cartCollection).doc(userId).set(cart.toJson());
  };
});

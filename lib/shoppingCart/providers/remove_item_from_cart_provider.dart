import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/shoppingCart/models/cart.dart';

typedef RemoveFromCart = Future<void> Function(
    String userId, String propertyId);

final removeFromCartProvider = Provider<RemoveFromCart>((ref) {
  final firestore = FirebaseFirestore.instance;
  const cartCollection = 'cart';

  return (String userId, String propertyId) async {
    var doc = await firestore.collection(cartCollection).doc(userId).get();
    var cart = Cart.fromJson(doc.data()!);

    cart = Cart(
      userId: cart.userId,
      items: List.from(cart.items)
        ..removeWhere((item) => item.postId == propertyId),
      frompostId: cart.frompostId,
    );

    await firestore.collection(cartCollection).doc(userId).set(cart.toJson());
  };
});

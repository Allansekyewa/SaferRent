import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saferent/shoppingCart/models/cart.dart';
import 'package:saferent/shoppingCart/models/cart_items.dart';

final cartProvider =
    StateNotifierProvider<CartProvider, Cart>((ref) => CartProvider());

class CartProvider extends StateNotifier<Cart> {
  final _firestore = FirebaseFirestore.instance;
  final _cartCollection = 'cart';

  CartProvider() : super(const Cart(userId: '', items: [], frompostId: ''));

  void initialize(String userId, String frompostId) {
    state = Cart(userId: userId, items: [], frompostId: frompostId);
  }

  double get totalPrice {
    return state.items.fold(0, (total, current) => total + current.amount);
  }

  int get badgeCount {
    return state.items.length;
  }

  Future<void> addCartItem(CartItem item) async {
    state = Cart(
        userId: state.userId,
        items: List.from(state.items)..add(item),
        frompostId: state.frompostId);
    await _saveCart();
  }

  Future<void> removeCartItem(String propertyId) async {
    List<CartItem> updatedItems = List.from(state.items);
    print("Before removal: ${updatedItems.map((item) => item.postId)}");

    updatedItems.removeWhere((item) => item.postId == propertyId);

    print("After removal: ${updatedItems.map((item) => item.postId)}");

    if (updatedItems.length < state.items.length) {
      state = Cart(
        userId: state.userId,
        frompostId: state.frompostId,
        items: updatedItems,
      );

      await _saveCart();
    }
  }

  Future<void> clearCart() async {
    state = Cart(userId: state.userId, items: [], frompostId: state.frompostId);
    await _saveCart();
  }

  Future<void> _saveCart() async {
    try {
      if (state.userId == null || state.userId.isEmpty) {
        // Handle the case where the user ID is null or empty
        print("User ID is null or empty. Cart not saved.");
        return; // or throw an exception, depending on your application logic
      }

      await _firestore
          .collection(_cartCollection)
          .doc(state.userId)
          .set(state.toJson());
    } catch (e) {
      print("Error saving cart: $e");
    }
  }

  Future<void> loadCart(String userId) async {
    var doc = await _firestore.collection(_cartCollection).doc(userId).get();
    state = Cart.fromJson(doc.data()!);
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saferent/shoppingCart/models/cart.dart';
import 'package:saferent/shoppingCart/models/cart_items.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';

final cartProvider =
    StateNotifierProvider<CartProvider, Cart>((ref) => CartProvider());

class CartProvider extends StateNotifier<Cart> {
  final _firestore = FirebaseFirestore.instance;
  final _cartCollection = 'cart';

  CartProvider() : super(const Cart(userId: '', items: [], frompostId: ''));

  void initialize(String userId, String frompostId) {
    // added const here wasnt here
    state = Cart(userId: userId, items: const [], frompostId: frompostId);
  }

  double get totalPrice {
    return state.items.fold(0, (total, current) => total + current.amount);
  }

  int get badgeCount {
    return state.items.length;
  }

  Future<void> addCartItem(CartItem item) async {
    var postDoc = await _firestore
        .collection(FirebaseCollectionName.posts)
        .doc(item.postId)
        .get();
    var postData = postDoc.data();

    if (postData != null) {
      item = item.copyWith(
        description: postData['description'],
        thumbnail: postData['thumbnailUrl'],
      );
    }

    // Check if the post is already in the cart
    if (state.items.any((cartItem) => cartItem.postId == item.postId)) {
      // Show a toast message
      Fluttertoast.showToast(
        msg: "Tour already booked",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        fontSize: 12,
      );
    } else {
      state = Cart(
        userId: state.userId,
        items: List.from(state.items)..add(item),
        frompostId: state.frompostId,
      );
      await _saveCart();
      Fluttertoast.showToast(
          msg: "Tour Successfully Booked",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          fontSize: 12);
    }

    // Use the thumbnailProvider to get the thumbnail
  }

  Future<void> removeCartItem(String propertyId) async {
    List<CartItem> updatedItems = List.from(state.items);

    updatedItems.removeWhere((item) => item.postId == propertyId);

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
    state = Cart(
        userId: state.userId, items: const [], frompostId: state.frompostId);
    await _saveCart();
  }

  Future<void> _saveCart() async {
    try {
      if (state.userId.isEmpty) {
        return;
      }

      await _firestore
          .collection(_cartCollection)
          .doc(state.userId)
          .set(state.toJson());
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> loadCart(String userId) async {
    var doc = await _firestore.collection(_cartCollection).doc(userId).get();
    state = Cart.fromJson(doc.data()!);
  }
}

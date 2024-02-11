import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:saferent/shoppingCart/models/cart.dart';
import 'package:saferent/shoppingCart/models/cart_items.dart';
import 'package:saferent/state/constants/firebase_collection_names.dart';
import 'package:collection/collection.dart'; // Import for firstWhereOrNull

final cartProvider =
    StateNotifierProvider<CartProvider, Cart>((ref) => CartProvider());

class CartProvider extends StateNotifier<Cart> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _cartCollection = 'cart';
  final List<CartItem> _removedItems = []; // Store removed items temporarily

  CartProvider() : super(const Cart(userId: '', items: [], frompostId: ''));

  void initialize(String userId, String frompostId) {
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

    if (state.items.any((cartItem) => cartItem.postId == item.postId)) {
      _showToastMessage("Tour already booked");
    } else {
      state = Cart(
        userId: state.userId,
        items: List.of(state.items)..add(item),
        frompostId: state.frompostId,
      );
      await _saveCart();
      _showToastMessage("Tour Successfully Booked");
    }
  }

  Future<void> removeCartItem(String propertyId) async {
    // Find the item to remove
    CartItem? removedItem =
        state.items.firstWhereOrNull((item) => item.postId == propertyId);

    if (removedItem != null) {
      _removedItems.add(removedItem); // Store removed item
    }

    List<CartItem> updatedItems = List.of(state.items);

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

  Future<void> reverseLastRemovedItem() async {
    if (_removedItems.isNotEmpty) {
      CartItem lastRemovedItem = _removedItems.removeLast();

      state = Cart(
        userId: state.userId,
        frompostId: state.frompostId,
        items: List.of(state.items)..add(lastRemovedItem),
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
    } catch (e) {
      // Handle error here or provide feedback to the user
    }
  }

  Future<void> loadCart(String userId) async {
    try {
      var doc = await _firestore.collection(_cartCollection).doc(userId).get();
      state = Cart.fromJson(doc.data()!);
    } catch (e) {
      // Handle error here or provide feedback to the user
    }
  }

  void _showToastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      fontSize: 12,
    );
  }
}

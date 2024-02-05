import 'package:flutter/foundation.dart' show immutable;
import 'package:saferent/shoppingCart/models/cart_items.dart';
import 'package:saferent/state/posts/typedefs/post_id.dart';
import 'package:saferent/state/posts/typedefs/user_id.dart';

@immutable
class Cart {
  final UserId userId; // Unique identifier for the user
  final List<CartItem> items;
  final PostId frompostId;

  const Cart(
      {required this.userId, required this.items, required this.frompostId});

  Cart.fromJson(Map<dynamic, dynamic> json)
      : userId = json['userId'],
        frompostId = json['frompostId'],
        items = (json['items'] as List)
            .map((item) => CartItem.fromJson(item as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'postId': frompostId,
        'items': items.map((item) => item.toJson()).toList(),
      };
  double get totalPrice {
    return items.fold(0, (total, current) => total + current.amount);
  }
}

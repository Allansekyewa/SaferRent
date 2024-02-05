import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/shoppingCart/providers/cart_management_provider.dart';

final totalPriceProvider = StateProvider<double>((ref) {
  final cart = ref.watch(cartProvider);
  return cart.totalPrice.toDouble();
});

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/payments/view/payment_view.dart';
import 'package:saferent/shoppingCart/providers/cart_management_provider.dart';
import 'package:saferent/views/components/animations/added_to_cart.dart';
import 'package:saferent/views/components/animations/no_cart_animation_view.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class CartViewPage extends ConsumerWidget {
  const CartViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          ' Your Booked Tours',
          style: TextStyle(
              fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          if (cart.items.isNotEmpty) // Conditionally show refresh icon
            IconButton(
                onPressed: () {
                  ref.read(cartProvider.notifier).reverseLastRemovedItem();
                },
                icon: const Icon(
                  CupertinoIcons.refresh_circled,
                  size: 18,
                  color: Colors.red,
                ))
        ],
      ),
      body: cart.items.isEmpty
          ? const Center(
              child: NoCartAnimationWords(
              text: 'No Tours Booked Yet',
            ))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: AppColors.butttonColor,
                        child: ListTile(
                          leading: const SizedBox(
                            height: 50,
                            width: 50,
                            child: AddedToCart(),
                          ),
                          title: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  item.description!,
                                  style: const TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ugx ${item.amount.toStringAsFixed(0)}: Property Tour Fee',
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.red),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(
                              CupertinoIcons.delete_solid,
                              size: 15,
                              color: Colors.purple,
                            ),
                            onPressed: () {
                              ref
                                  .read(cartProvider.notifier)
                                  .removeCartItem(item.postId);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextButton.icon(
                            onPressed: () {
                              ref
                                  .read(cartProvider.notifier)
                                  .clearCart(); // Clear cart functionality
                            },
                            icon: const Icon(
                              CupertinoIcons.cart_fill_badge_minus,
                              color: Colors.yellow,
                              size: 18,
                            ),
                            label: const Text(
                              'Clear Bookings',
                              style:
                                  TextStyle(fontSize: 10, color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: AppColors.butttonColor,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            'Total: Ugx ${cart.totalPrice.toStringAsFixed(0)}/=',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PaymentPage(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.payments_outlined,
                              size: 14,
                              color: Colors.purple,
                            ),
                            label: const Text(
                              'Proceed to Payments',
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

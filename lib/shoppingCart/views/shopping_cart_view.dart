import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/payments/view/payment_view.dart';
import 'package:saferent/shoppingCart/providers/cart_management_provider.dart';
import 'package:saferent/views/components/animations/no_cart_animation_view.dart';

class CartViewPage extends ConsumerWidget {
  const CartViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SafeRents Tours Basket',
          style: TextStyle(fontSize: 12, color: Colors.red),
        ),
      ),
      body: cart.items.isEmpty
          ? const Center(
              child: NoCartAnimationWords(text: 'No Tours Booked Yet'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return ListTile(
                        leading: Container(
                            width: 50, child: Image.network(item.thumbnail)),
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.description,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ugx ${item.amount.toStringAsFixed(0)}: Property Tour Fee',
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.blue),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            CupertinoIcons.minus_circled,
                            size: 15,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            ref
                                .read(cartProvider.notifier)
                                .removeCartItem(item.postId);
                          },
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
                          child: TextButton(
                            onPressed: () {
                              ref
                                  .read(cartProvider.notifier)
                                  .clearCart(); // Clear cart functionality
                            },
                            child: const Text(
                              'Clear Cart',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Text(
                            'Total: Ugx ${cart.totalPrice.toStringAsFixed(0)}/=',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PaymentPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Proceed to Payments',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
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

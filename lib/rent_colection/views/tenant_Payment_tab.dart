import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/payments/view/payment_view.dart';

class TenantPaymentTab extends ConsumerStatefulWidget {
  const TenantPaymentTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TenantPaymentTabState();
}

class _TenantPaymentTabState extends ConsumerState<TenantPaymentTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Full Names :',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Unit Number :',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Location :',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'LandLords Contact :',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'LandLord Ref Id :',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Rent Amount Monthly :',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Payment For :',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Center(
            child: TextButton.icon(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const PaymentPage()));
              },
              label: const Text(
                'Pay & Collect Rent',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
              icon: const Icon(
                Icons.payments,
                color: Color.fromARGB(255, 207, 9, 9),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

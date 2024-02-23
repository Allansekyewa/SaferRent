import 'package:flutter/material.dart';
import 'package:saferent/rent_colection/views/landLord_payment_screen.dart';
import 'package:saferent/rent_colection/views/tenant_payment_view.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class RentPaymentPage extends StatelessWidget {
  const RentPaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Divider(
                color: Colors.green,
              ),
              const Icon(
                Icons.payments,
                size: 150,
                color: Colors.green,
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width *
                    0.9, // 90% of screen width
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black),
                ),
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    const Text(
                      'Choose One Below',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LandLordPAymentView()));
                      },
                      icon: const Icon(
                        Icons.admin_panel_settings,
                        color: Colors.green,
                      ),
                      label: const Text(
                        'Landlords',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const TenantPaymentPage()));
                      },
                      icon: const Icon(
                        Icons.bed,
                        color: Colors.purple,
                      ),
                      label: const Text(
                        'Tenants',
                        style: TextStyle(fontSize: 12, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(color: Colors.green),
            ],
          ),
        ),
      ),
    );
  }
}

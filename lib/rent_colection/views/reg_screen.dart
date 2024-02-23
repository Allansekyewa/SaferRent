import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/rent_colection/views/payments.dart';
import 'package:saferent/rent_colection/views/register_screen.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class RentRegScreen extends ConsumerStatefulWidget {
  const RentRegScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RentRegScreenState();
}

class _RentRegScreenState extends ConsumerState<RentRegScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.butttonColor,
          title: const Text(
            'Rent Collection',
            style: TextStyle(
                fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(tabs: [
            Tab(
              child: Text(
                'Register',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
            Tab(
              child: Text('Payments', style: TextStyle(fontSize: 12)),
            )
          ]),
        ),
        body: const TabBarView(children: [RegisterPage(), RentPaymentPage()]),
      ),
    );
  }
}

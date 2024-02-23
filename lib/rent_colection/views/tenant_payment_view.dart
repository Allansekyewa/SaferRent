import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/rent_colection/views/tenant_Payment_tab.dart';
import 'package:saferent/rent_colection/views/tenant_reciept_view.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class TenantPaymentPage extends ConsumerStatefulWidget {
  const TenantPaymentPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TenantPaymentPageState();
}

class _TenantPaymentPageState extends ConsumerState<TenantPaymentPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          backgroundColor: AppColors.butttonColor,
          title: const Text(
            'My Payment DashBoard',
            style: TextStyle(fontSize: 15, color: Colors.red),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Payments',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              Tab(
                child: Text(
                  'My Reciepts',
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [TenantPaymentTab(), TenantsReciept()],
        ),
      ),
    );
  }
}

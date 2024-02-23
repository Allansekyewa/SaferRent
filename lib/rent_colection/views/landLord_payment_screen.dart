import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/rent_colection/views/landlord_my_tenants_view.dart';
import 'package:saferent/rent_colection/views/landlord_occupancy_view.dart';
import 'package:saferent/rent_colection/views/landlord_payment_tab.dart';

class LandLordPAymentView extends ConsumerStatefulWidget {
  const LandLordPAymentView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LandLordPAymentViewState();
}

class _LandLordPAymentViewState extends ConsumerState<LandLordPAymentView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: const Text(
            'LandLord Main Dashboard',
            style: TextStyle(fontSize: 12, color: Colors.black),
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
                  'Occupancy ',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'My Tenants',
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ),
        body: const TabBarView(children: [
          LandlordPaymentTab(),
          LandLordOccupancy(),
          LandLordMyTenantsView()
        ]),
      ),
    );
  }
}

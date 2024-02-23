import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LandlordPaymentTab extends ConsumerStatefulWidget {
  const LandlordPaymentTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LandlordPaymentTabState();
}

class _LandlordPaymentTabState extends ConsumerState<LandlordPaymentTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}

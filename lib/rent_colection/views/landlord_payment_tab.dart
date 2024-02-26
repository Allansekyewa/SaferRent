import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/views/components/constants/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LandlordPaymentTab extends ConsumerStatefulWidget {
  const LandlordPaymentTab({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LandlordPaymentTabState createState() => _LandlordPaymentTabState();
}

class _LandlordPaymentTabState extends ConsumerState<LandlordPaymentTab> {
  late List<PaymentStatusData> data;

  @override
  void initState() {
    super.initState();
    data = [
      PaymentStatusData('Paid', 7, Colors.green),
      PaymentStatusData('Pending', 5, Colors.orange),
      PaymentStatusData('Defaulters', 2, Colors.red),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.butttonColor,
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 1),
            SfCircularChart(
              legend: const Legend(isVisible: true),
              series: <CircularSeries>[
                PieSeries<PaymentStatusData, String>(
                  dataSource: data,
                  xValueMapper: (PaymentStatusData status, _) => status.status,
                  yValueMapper: (PaymentStatusData status, _) => status.count,
                  pointColorMapper: (PaymentStatusData status, _) =>
                      status.color,
                  dataLabelSettings: const DataLabelSettings(isVisible: true),
                )
              ],
            ),
            const SizedBox(height: 20),
            const Text('Estimated Collections:'),
            const SizedBox(height: 5),
            const Text('Current Collections:'),
            const SizedBox(height: 5),
            const Text('Pending Collections:'),
            const SizedBox(height: 5),
            const Text('SafeRents Tax => (10% monthly colletions):'),
            const SizedBox(height: 12),
            const Text(
              'Your Total Collections:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentStatusData {
  final String status;
  final int count;
  final Color color;

  PaymentStatusData(this.status, this.count, this.color);
}

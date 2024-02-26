import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/views/components/constants/app_colors.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LandLordOccupancy extends ConsumerStatefulWidget {
  const LandLordOccupancy({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LandlordOccupancyTabState createState() => _LandlordOccupancyTabState();
}

class _LandlordOccupancyTabState extends ConsumerState<LandLordOccupancy> {
  late List<OccupancyStatusData> data;

  @override
  void initState() {
    super.initState();
    data = [
      OccupancyStatusData('Taken', 7, Colors.green),
      OccupancyStatusData('Pending', 5, Colors.red),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  PieSeries<OccupancyStatusData, String>(
                    dataSource: data,
                    xValueMapper: (OccupancyStatusData status, _) =>
                        status.status,
                    yValueMapper: (OccupancyStatusData status, _) =>
                        status.count,
                    pointColorMapper: (OccupancyStatusData status, _) =>
                        status.color,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  )
                ],
              ),
              const SizedBox(height: 20),
              // TODO: Add columns for paid, pending, and defaulted tenants
            ],
          ),
        ),
      ),
    );
  }
}

class OccupancyStatusData {
  final String status;
  final int count;
  final Color color;

  OccupancyStatusData(this.status, this.count, this.color);
}

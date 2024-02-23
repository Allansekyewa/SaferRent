import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LandLordOccupancy extends ConsumerStatefulWidget {
  const LandLordOccupancy({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _LandLordOccupancyState();
}

class _LandLordOccupancyState extends ConsumerState<LandLordOccupancy> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Divider(
              color: Colors.blue,
            ),
            Text(
              "Occuapancy will help you in tracking the number of units you have in difffernt Locations More so the taken ones the enpty ones in real time",
              style: TextStyle(fontSize: 11, color: Colors.red),
            ),
            Divider(
              color: Colors.blue,
            ),
          ],
        )),
      ),
    );
  }
}

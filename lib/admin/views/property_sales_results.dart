import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class PropertySalesView extends StatefulWidget {
  const PropertySalesView({super.key});

  @override
  State<PropertySalesView> createState() => _PropertySalesViewState();
}

class _PropertySalesViewState extends State<PropertySalesView> {
  late Stream<QuerySnapshot> propertySales;
  @override
  void initState() {
    super.initState();
    propertySales = FirebaseFirestore.instance
        .collection('property_sales')
        .orderBy('created_At', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Property Sales List',
          style: TextStyle(fontSize: 12),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.green,
                        Colors.green,
                        Colors.green,
                        Colors.green
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.1, 0.7, 0.7, 0.6])),
              child: StreamBuilder(
                stream: propertySales,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CupertinoActivityIndicator();
                  }
                  if (snapshot.hasError) {
                    return const Text("Error on Data");
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Text('No Data Available At The Moment');
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      var data = doc.data() as Map<String, dynamic>;

                      String type = data['property_type'] ?? 'N/A';
                      String description = data['description'] ?? 'N/A';
                      String contact = data['phone_number'] ?? 'N/A';
                      String location = data['location'] ?? 'N/A';
                      String names = data['names'] ?? 'N/A';
                      String creationDate = data['created_At'] != null
                          ? DateFormat('dd-MM-yyyy-kk:mm').format(
                              (data['created_At'] as Timestamp).toDate())
                          : 'N/A';
                      return Container(
                          margin: const EdgeInsets.all(4.0),
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            color: AppColors.butttonColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ListTile(
                            title: const Text(
                              'Property Sales Page',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.green),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Type: $type',
                                  style: const TextStyle(fontSize: 10),
                                ),
                                Text('Names:$names',
                                    style: const TextStyle(fontSize: 10)),
                                Text('Contacts:$contact',
                                    style: const TextStyle(fontSize: 10)),
                                Text('Location:$location',
                                    style: const TextStyle(fontSize: 10)),
                                Text('Description:$description',
                                    style: const TextStyle(fontSize: 10)),
                                Text(
                                  'Date: $creationDate',
                                  style: const TextStyle(fontSize: 10),
                                )
                              ],
                            ),
                          ));
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

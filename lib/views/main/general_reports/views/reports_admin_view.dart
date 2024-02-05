import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ReportsAdminView extends StatefulWidget {
  const ReportsAdminView({super.key});

  @override
  State<ReportsAdminView> createState() => _ReportsAdminViewState();
}

class _ReportsAdminViewState extends State<ReportsAdminView> {
  late Stream<QuerySnapshot> reportsAdmin;
  @override
  void initState() {
    super.initState();
    reportsAdmin = FirebaseFirestore.instance
        .collection('reports')
        .orderBy('created_At', descending: true)
        .snapshots();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SafeRents Field reports',
          style: TextStyle(fontSize: 10, color: Colors.purple),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SafeArea(
            child: Container(
              decoration: const BoxDecoration(color: Colors.purple),
              child: StreamBuilder(
                  stream: reportsAdmin,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CupertinoActivityIndicator();
                    }
                    if (snapshot.hasError) {
                      return const Text('Error On Data');
                    }
                    if (snapshot.data!.docs.isEmpty) {
                      return const Text('No Data Available At The Moment');
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var doc = snapshot.data!.docs[index];
                        var data = doc.data() as Map<String, dynamic>;

                        String reports = data['reports'] ?? 'N/A';
                        String creationDate = data['created_At'] != null
                            ? DateFormat('dd-MM-yyyy ⌚️ kk:mm').format(
                                (data['created_At'] as Timestamp).toDate())
                            : 'N/A';
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4.0)),
                          child: ListTile(
                            title: const Text(
                              'Field Report',
                              style: TextStyle(fontSize: 10, color: Colors.red),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Report:$reports',
                                  style: const TextStyle(fontSize: 10),
                                ),
                                Text('Date: $creationDate',
                                    style: const TextStyle(fontSize: 10))
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}

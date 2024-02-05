import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MaidsUiView extends StatefulWidget {
  MaidsUiView({Key? key}) : super(key: key);

  @override
  _MaidsUiViewState createState() => _MaidsUiViewState();
}

class _MaidsUiViewState extends State<MaidsUiView> {
  late Stream<QuerySnapshot> cleanerStream;
  @override
  void initState() {
    super.initState();
    cleanerStream = FirebaseFirestore.instance
        .collection('house_maids')
        .orderBy('created_At', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          ' House Maids',
          style: TextStyle(fontSize: 10, color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: [0.1, 0.7, 0.6, 0.1],
                  colors: [
                    Colors.blue,
                    Colors.blue,
                    Colors.white30,
                    Colors.blue
                  ],
                ),
                border: Border.all(color: Colors.blue), // Black border
                borderRadius: BorderRadius.circular(5),
              ),
              child: StreamBuilder(
                stream: cleanerStream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CupertinoActivityIndicator(); // Loading indicator
                  }

                  if (snapshot.hasError) {
                    return const Text('Error'); // Error message
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return const Text(
                        'No data available'); // Display a message for no data
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var document = snapshot.data!.docs[index];
                      var data = document.data() as Map<String, dynamic>;

                      String names = data['names'] ?? "N/A";
                      String phoneNumber = data['phone_number'] ?? "N/A";
                      String handlersName = data['Handlers_name'] ?? "N/A";
                      String handlersPhone = data['handlers_phonr'] ?? "N/A";
                      String description = data['description'] ?? "N/A";
                      String creationDate = data['created_At'] != null
                          ? DateFormat('dd-MM-yyyy ⌚️ kk:mm').format(
                              (data['created_At'] as Timestamp).toDate())
                          : "N/A";

                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                            subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Names: $names',
                                style: const TextStyle(fontSize: 10)),
                            Text('Phone Number: $phoneNumber',
                                style: const TextStyle(fontSize: 10)),
                            Text('HandlersNames: $handlersName',
                                style: const TextStyle(fontSize: 10)),
                            Text('HandlersPhone: $handlersPhone',
                                style: const TextStyle(fontSize: 10)),
                            Text('Description: $description',
                                style: const TextStyle(fontSize: 10)),
                            Text('Created: $creationDate',
                                style: const TextStyle(fontSize: 10))
                          ],
                        )),
                      );
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

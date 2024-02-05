import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Import the intl package

class MoversUiView extends StatefulWidget {
  const MoversUiView({Key? key}) : super(key: key);

  @override
  _MoversUiViewState createState() => _MoversUiViewState();
}

class _MoversUiViewState extends State<MoversUiView> {
  late Stream<QuerySnapshot> moversStream;

  @override
  void initState() {
    super.initState();
    // Set up a stream to listen for changes in the Firestore collection
    moversStream = FirebaseFirestore.instance
        .collection('Movers')
        .orderBy('created_At', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          'Move And shift your belongings with us Safely and Securely\n in time Either Present Or Absent',
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
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.7, 0.7, 0.6],
                  colors: [Colors.red, Colors.red, Colors.red, Colors.red],
                ),
                border: Border.all(color: Colors.red), // Black border
                borderRadius: BorderRadius.circular(10),
              ),
              child: StreamBuilder(
                stream: moversStream,
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

                      String companyName = data['Company_name'] ?? "N/A";
                      String location = data['location'] ?? "N/A";
                      String phoneNumber = data['phone_number'] ?? "N/A";
                      String creationDate = data['created_At'] != null
                          ? DateFormat('dd-MM-yyyy ⌚️ kk:mm').format(
                              (data['created_At'] as Timestamp).toDate())
                          : "N/A";
                      String names = data['names'] ?? "N/A";

                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                          title: Text('Company Name: $companyName',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Location: $location',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Phone Number: $phoneNumber',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Names: $names',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Created: $creationDate',
                                  style: const TextStyle(fontSize: 10))
                            ],
                          ),
                        ),
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

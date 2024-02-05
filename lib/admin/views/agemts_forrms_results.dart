import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class AgentsResultView extends StatefulWidget {
  const AgentsResultView({Key? key}) : super(key: key);
  @override
  _AgentsResultView createState() => _AgentsResultView();
}

class _AgentsResultView extends State<AgentsResultView> {
  late Stream<QuerySnapshot> agentsResultStream;
  @override
  void initState() {
    super.initState();
    agentsResultStream = FirebaseFirestore.instance
        .collection('agentsform')
        .orderBy('created_At', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'UnVerified Agents List',
          style: TextStyle(fontSize: 10, color: Colors.red),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: SafeArea(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.red, Colors.red, Colors.red],
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.7, 0.7, 0.6],
                ),
              ),
              child: StreamBuilder(
                stream: agentsResultStream,
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

                      String names = data['names'] ?? 'N/A';
                      String email = data['email'] ?? 'N/A';
                      String phoneNumber = data['phone_number'] ?? 'N/A';
                      String refNumber = data['referee-number'] ?? 'N/A';
                      String ninNumber = data['nin-number'] ?? 'N/A';
                      String location = data['location'] ?? 'N/A';
                      String educationLevel = data['education_level'] ?? 'N/A';
                      String creationDate = data['created_At'] != null
                          ? DateFormat('dd-MM-yyyy 🕰 kk:mm').format(
                              (data['created_At'] as Timestamp).toDate())
                          : 'N/A';
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            color: AppColors.butttonColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: ListTile(
                          title: const Text(
                            'UnVerified Agent',
                            style: TextStyle(fontSize: 12, color: Colors.red),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Name: $names',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Email: $email',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Phone Number: $phoneNumber',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Refree Number: $refNumber',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Nin Number: $ninNumber',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Location: $location',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Education Level : $educationLevel',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Date: $creationDate',
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

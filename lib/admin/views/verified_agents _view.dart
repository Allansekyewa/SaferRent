import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class VerifiedAgentsview extends StatefulWidget {
  const VerifiedAgentsview({super.key});

  @override
  State<VerifiedAgentsview> createState() => _VerifiedAgentsviewState();
}

class _VerifiedAgentsviewState extends State<VerifiedAgentsview> {
  late Stream<QuerySnapshot> verifiedAgents;

  @override
  void initState() {
    super.initState();
    verifiedAgents = FirebaseFirestore.instance
        .collection('Verified_Agents')
        .orderBy('created_At', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Verified Agents List',
          style: TextStyle(fontSize: 10, color: Colors.blue),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: const LinearGradient(
                  colors: [Colors.blue, Colors.blue, Colors.blue, Colors.blue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.7, 0.7, 0.6],
                ),
              ),
              child: StreamBuilder(
                stream: verifiedAgents,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CupertinoActivityIndicator();
                  }
                  if (snapshot.hasError) {
                    return const Text('Error on Data');
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const Text('No Data Available At The Moment');
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var doc = snapshot.data!.docs[index];
                      var data = doc.data() as Map<String, dynamic>;
                      String nin = data['nin-number'] ?? 'N/A';
                      String names = data['agent_id'] ?? 'N/A';
                      String phone = data['phone_number'] ?? 'N/A';
                      String referee = data['referee-number'] ?? "N/A";
                      String creationDate = data['created_At'] != null
                          ? DateFormat('dd-MM-yyyy ⏰ kk:mm').format(
                              (data['created_At'] as Timestamp).toDate(),
                            )
                          : 'N/A';
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: AppColors.butttonColor,
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: ListTile(
                          title: const Text(
                            'Verified Agent',
                            style: TextStyle(fontSize: 12, color: Colors.blue),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Names:$names',
                                style: const TextStyle(fontSize: 10),
                              ),
                              Text(
                                'Phone:$phone',
                                style: const TextStyle(fontSize: 10),
                              ),
                              Text(
                                'Nin:$nin',
                                style: const TextStyle(fontSize: 10),
                              ),
                              Text(
                                'RefNo:$referee',
                                style: const TextStyle(fontSize: 10),
                              ),
                              Text(
                                'Date: $creationDate',
                                style: const TextStyle(fontSize: 10),
                              )
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

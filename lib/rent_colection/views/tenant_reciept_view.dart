import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:saferent/views/components/animations/empty_animation_view.dart';

class TenantsReciept extends ConsumerStatefulWidget {
  const TenantsReciept({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TenantsRecieptState();
}

class _TenantsRecieptState extends ConsumerState<TenantsReciept> {
  late Stream<QuerySnapshot> paymentsStream;
  @override
  void initState() {
    super.initState();
    // Set up a stream to listen for changes in the Firestore collection
    paymentsStream = FirebaseFirestore.instance
        .collection('payments')
        .orderBy('paidAt', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: [0.1, 0.7, 0.7, 0.6],
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.white30,
                    Colors.white
                  ],
                ),
                border: Border.all(color: Colors.white), // Black border
                borderRadius: BorderRadius.circular(5),
              ),
              child: StreamBuilder(
                stream: paymentsStream,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CupertinoActivityIndicator();
                  }
                  if (snapshot.hasError) {
                    return const Text('Error');
                  }
                  if (snapshot.data!.docs.isEmpty) {
                    return const EmptyContentsAnimationzwords(
                        text:
                            'No Reciepts Yet Since Youve Not Made Any Payments Yet'); // Display a message for no data
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var document = snapshot.data!.docs[index];
                      var data = document.data() as Map<String, dynamic>;
                      String id = data['id'] ?? "N/A";
                      String clientName = data['Client Names:'] ?? 'N/A';
                      String paymentTo = data['Paid To:'] ?? "N/A";
                      String reason = data['Reason Being:'] ?? "N/A";
                      String amount = data['Amount'] ?? "N/A";
                      String rentDuration =
                          data['Payment for Month :'] ?? "N/A";
                      String paymentDate = data['paidAt'] != null
                          ? DateFormat('dd-MM-yyyy ⌚️ kk:mm')
                              .format((data['paidAt'] as Timestamp).toDate())
                          : "N/A";
                      return Container(
                        margin: const EdgeInsets.all(4.0),
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: ListTile(
                          title: Text('Payment ID: $id',
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(
                                    Icons.cable,
                                    color: Colors.red,
                                    size: 15,
                                  ),
                                  Text(
                                    "SafeRents",
                                    style: TextStyle(fontSize: 15),
                                  )
                                ],
                              ),
                              Text('Client Names: $clientName',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Paid: $paymentTo',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Payment For: $reason',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Amount: $amount',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Client Name: $clientName',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Reason: $reason',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Paid At: $paymentDate',
                                  style: const TextStyle(fontSize: 10)),
                              Text('Duration: $rentDuration',
                                  style: const TextStyle(fontSize: 10)),
                              Text(
                                  'Hello Mr/Mrs $clientName SafeRents Hails You For Trusting Us And doing bussiness with Us This reciept only works on on only one speicied portal.Get Back to Us about Your Property Tour Experience on 0761439068 or email  alsekx@gmail.com REGARDS 😎')
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

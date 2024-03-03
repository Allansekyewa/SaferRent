import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:saferent/views/components/animations/empty_animation_view.dart';

class RecieptsView extends StatefulWidget {
  const RecieptsView({Key? key}) : super(key: key);

  @override
  _RecieptsViewState createState() => _RecieptsViewState();
}

class _RecieptsViewState extends State<RecieptsView> {
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
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Your Receipts',
          style: TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                      return const Text('Error'); // Error message
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
                        String agentPhoneNumber =
                            data['agentPhoneNumber'] ?? "N/A";
                        String serviceProvider =
                            data['serviceProvider'] ?? "N/A";
                        String paymentFor = data['paymentFor'] ?? "N/A";

                        double amount = data['amount'] ?? 0.0;

                        String clientsName = data['clientsName'] ?? "N/A";
                        String reason = data['reason'] ?? "N/A";
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
                                    Text(
                                        'Agent Phone Number: $agentPhoneNumber',
                                        style: const TextStyle(fontSize: 10)),
                                    Text('Service Provider: $serviceProvider',
                                        style: const TextStyle(fontSize: 10)),
                                    Text('Payment For: $paymentFor',
                                        style: const TextStyle(fontSize: 10)),
                                    Text('Amount: $amount',
                                        style: const TextStyle(fontSize: 10)),
                                    Text('Client Name: $clientsName',
                                        style: const TextStyle(fontSize: 10)),
                                    Text('Reason: $reason',
                                        style: const TextStyle(fontSize: 10)),
                                    Text('Paid At: $paymentDate',
                                        style: const TextStyle(fontSize: 10)),
                                    Text(
                                        'Hello Mr/Mrs $clientsName SafeRents Hails You For Trusting Us And doing bussiness with Us This reciept only works on on only one speicied portal.Get Back to Us about Your Property Tour Experience on 0761439068 or email  alsekx@gmail.com REGARDS 😎'),
                                    const Text(
                                        'N.B once  a matched housed is foun un available another tour of your choice in the sane area will be granted to you to even your missing tour')
                                  ]),
                            ));
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

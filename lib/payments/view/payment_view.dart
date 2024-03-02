import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:saferent/payments/model/airtel/request_apis_airtel.dart';
import 'package:saferent/payments/model/mtn/request_api_mtn.dart';
import 'package:saferent/shoppingCart/providers/cart_total_price_provider.dart';
import 'package:saferent/views/components/constants/app_colors.dart';

class PaymentPage extends ConsumerStatefulWidget {
  const PaymentPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  final mtnLogo = Image.asset(
    "assets/mtn.jpg",
    height: 20,
  );
  final airtelLogo = Image.asset(
    "assets/airtel.png",
    height: 20,
  );

  TextEditingController phoneControler = TextEditingController();
  String amountError = "";
  String selectedPaymentMethod = '';
  double amountToPay = 0;
  String phoneError = "";
  String phoneNumber = '';
  bool showWelcomeText = true;

  @override
  void initState() {
    super.initState();
    phoneControler.addListener(
      () {
        if (phoneControler.text.isNotEmpty) {
          setState(
            () {
              phoneError = "";
            },
          );
        }
      },
    );
  }

  void selectPaymentMethod(String method) {
    setState(
      () {
        selectedPaymentMethod = method;
        showWelcomeText = false;
      },
    );
  }

  void makePayment() {
    if (phoneControler.text.isEmpty) {
      setState(() {
        phoneError = "Please Enter a Phone Number(Billing Number)";
      });
      return;
    }
    if (selectedPaymentMethod == "MTN MoMo") {
      // Implement MTN Money payment logic here
      initiateMTNPayment(
        amountToPay,
        phoneNumber,
        'your_external_id',
        'just pay',
        'payment pls',
      ).then(
        (paymentResult) {
          showPaymentConfirmationDialog(paymentResult);
        },
      );
    } else if (selectedPaymentMethod == "Airtel Money") {
      // Implement Airtel Money payment logic here
      initiateAirtelPayment(amountToPay, phoneNumber).then(
        (paymentResult) {
          showPaymentConfirmationDialog(paymentResult);
        },
      );
    } else {
      showPaymentResultDialog("Invalid payment method selected");
    }
  }

  void showPaymentConfirmationDialog(String paymentResult) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.butttonColor,
          title: const Text(
            "Payment Confirmation",
            style: TextStyle(
              fontSize: 10.0,
            ),
          ),
          content: Text(
            "You are about to pay  $amountToPay to SafeRents  using $selectedPaymentMethod ",
            style: const TextStyle(
              fontSize: 10.0,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                phoneControler.clear();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 10),
              ),
            ),
            TextButton(
              child:
                  const Text("Confirm", style: TextStyle(color: Colors.black)),
              onPressed: () async {
                //TODO Implement after payment
                //inital payment and api processing
                //reciept generation to reciept tab
              },
            )
          ],
        );
      },
    );
  }

  void showPaymentResultDialog(String result) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            "Payment Confirmation",
            style: TextStyle(
              fontSize: 10.0,
              color: result == "success" ? Colors.green : Colors.red,
            ),
          ),
          content: Text(
            result == "success"
                ? "You paid SafeRents $amountToPay using $selectedPaymentMethod. A Receipt Has Been Sent To You For More Guidannce For Querries call 0761439068 !Thanks"
                : "Payment using $selectedPaymentMethod failed. Please try again with another alternatve payment method ",
            style: const TextStyle(
              fontSize: 10,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPrice = ref.watch(totalPriceProvider);
    amountToPay = totalPrice;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.orange,
        appBar: AppBar(
          backgroundColor: AppColors.butttonColor,
          title: const Text(
            "Make Payments",
            style: TextStyle(fontSize: 15.0, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple),
                  color: AppColors.butttonColor,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                // 40 units on top and bottom
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'After Payments Have been Succesfully Processed A Reciept Will Be Sent To The Reciept Tab Including SafeRents Tour Details And Agent Details More So the Agents Contacts REGARDS 🤑....',
                        style: TextStyle(fontSize: 10, color: Colors.red),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      if (showWelcomeText)
                        const Text(
                          "Make Payments ",
                          style: TextStyle(fontSize: 10.0),
                        ),
                      DropdownButton<String>(
                        borderRadius: BorderRadius.circular(20),
                        value: selectedPaymentMethod,
                        items: ["", "MTN MoMo", "Airtel Money"].map(
                          (method) {
                            if (method == '') {
                              return DropdownMenuItem(
                                value: method,
                                child: Text(
                                  method.isNotEmpty
                                      ? method
                                      : "Select Payment Method",
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                  ),
                                ),
                              );
                            } else {
                              return DropdownMenuItem(
                                value: method,
                                child: Row(
                                  children: [
                                    method == "MTN MoMo" ? mtnLogo : airtelLogo,
                                    const SizedBox(width: 10),
                                    Text(
                                      method.isNotEmpty
                                          ? method
                                          : "Select Payment Method",
                                      style: const TextStyle(
                                        fontSize: 10.0,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }
                          },
                        ).toList(),
                        onChanged: (String? method) {
                          selectPaymentMethod(method!);
                        },
                      ),
                      selectedPaymentMethod.isNotEmpty
                          ? Column(
                              children: [
                                Text(
                                  selectedPaymentMethod == "MTN MoMo"
                                      ? "Make Payments to the SafeRents using MTN MoMo"
                                      : "Make Payments to the SafeRents using Airtel Money",
                                  style: const TextStyle(fontSize: 10.0),
                                ),
                                const Divider(
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: phoneControler,
                                  decoration: InputDecoration(
                                    labelText: "Enter Number",
                                    errorText: phoneError.isNotEmpty
                                        ? phoneError
                                        : null,
                                    labelStyle: const TextStyle(fontSize: 8),
                                    hintText: "Enter  Mobile Money Number",
                                    hintStyle: const TextStyle(
                                      fontSize: 12,
                                    ),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white30,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      makePayment();
                                    },
                                    style: TextButton.styleFrom(
                                      foregroundColor: Colors.black,
                                    ),
                                    child: Text(
                                      'Pay 💵 ${totalPrice.toStringAsFixed(0)} Ugx',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.red),
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

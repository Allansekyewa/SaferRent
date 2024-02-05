import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> initiateAirtelPayment(
    double amountToPay, String phoneNumber) async {
  try {
    // Make an HTTP POST request to the Airtel Money API to initiate the payment.
    final response = await http.post(
      Uri.parse('https://openapiuat.airtel.africa/initiate-payment'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer YOUR_AIRTEL_MONEY_ACCESS_TOKEN',
      },
      body: jsonEncode({
        'amount': amountToPay,
        'phone_number': phoneNumber,
      }),
    );

    // Check the HTTP status code of the response.
    if (response.statusCode == 200) {
      // Payment initiation was successful.
      final paymentResponse = jsonDecode(response.body);
      final paymentStatus = paymentResponse['status'];

      // Check the payment status.
      if (paymentStatus == 'success') {
        // Payment was successful, return a success message.
        return "Payment successful.";
      } else {
        // Payment failed, return an error message.
        return "Payment failed: ${paymentResponse['message']}";
      }
    } else {
      // API call failed, return an error message.
      return "Payment initiation error: ${response.statusCode}";
    }
  } catch (error) {
    // Handle network or other errors.
    return "Payment initiation error: $error";
  }
}

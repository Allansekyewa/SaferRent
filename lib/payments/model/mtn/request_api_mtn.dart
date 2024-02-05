import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> initiateMTNPayment(double amountToPay, String phoneNumber,
    String externalId, String payerMessage, String payeeNote) async {
  try {
    // Make an HTTP POST request to the MTN MoMo API to initiate the payment.
    final response = await http.post(
      Uri.parse(
          'https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay'),
      headers: <String, String>{
        'X-Reference-Id': '3b3b0790-d533-4920-b06c-3c0f6b6c7612',
        'X-Target-Environment': 'sandbox',
        'Ocp-Apim-Subscription-Key': 'da9274fa8bdb4272b659c8a30e5372f2',
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSMjU2In0.eyJjbGllbnRJZCI6IjNiM2IwNzkwLWQ1MzMtNDkyMC1iMDZjLTNjMGY2YjZjNzYxMiIsImV4cGlyZXMiOiIyMDIzLTExLTEzVDEzOjUyOjM0LjM5MCIsInNlc3Npb25JZCI6ImQyMWJjMWRaVBaphIR2-xeVTShyo9YLNPo_e9-rfoym7txUDoyptwd1fLVKxQy-xcnzKWn07eiauug-jo9bDLsZzvkjSjRmAAKygWdlhyUwOoZdXXRGxBzxOzl_IG8YTSloWcFelJYsqSfNg',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "amount": amountToPay,
        "currency": "EUR",
        "externalId": externalId,
        "payer": {"partyIdType": "MSISDN", "partyId": phoneNumber},
        "payerMessage": payerMessage,
        "payeeNote": payeeNote
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

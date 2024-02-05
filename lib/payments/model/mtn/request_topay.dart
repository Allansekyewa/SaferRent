import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  var headers = {
    'X-Reference-Id': '3b3b0790-d533-4920-b06c-3c0f6b6c7612',
    'X-Target-Environment': 'sandbox',
    'Ocp-Apim-Subscription-Key': 'da9274fa8bdb4272b659c8a30e5372f2',
    'Authorization':
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSMjU2In0.eyJjbGllbnRJZCI6IjNiM2IwNzkwLWQ1MzMtNDkyMC1iMDZjLTNjMGY2YjZjNzYxMiIsImV4cGlyZXMiOiIyMDIzLTExLTEzVDEzOjUyOjM0LjM5MCIsInNlc3Npb25JZCI6ImQyMWJjMWRaVBaphIR2-xeVTShyo9YLNPo_e9-rfoym7txUDoyptwd1fLVKxQy-xcnzKWn07eiauug-jo9bDLsZzvkjSjRmAAKygWdlhyUwOoZdXXRGxBzxOzl_IG8YTSloWcFelJYsqSfNg',
    'Content-Type': 'application/json',
  };
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay'));
  request.body = json.encode({
    "amount": "990",
    "currency": "EUR",
    "externalId": "your_external_id",
    "payer": {"partyIdType": "MSISDN", "partyId": "9292929"},
    "payerMessage": "just pay",
    "payeeNote": "payment pls"
  });
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(
          'Request failed with status: ${response.statusCode}, ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Error making the request: $e');
  }
}

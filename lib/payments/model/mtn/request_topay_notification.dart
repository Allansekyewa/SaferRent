import 'package:http/http.dart' as http;

void main() async {
  var headers = {
    'Ocp-Apim-Subscription-Key': 'da9274fa8bdb4272b659c8a30e5372f2',
    'X-Target-Environment': 'sandbox',
    'Authorization': 'Bearer your_access_token_here',
  };

  var request = http.Request(
      'GET',
      Uri.parse(
          'https://sandbox.momodeveloper.mtn.com/collection/v1_0/requesttopay/3b3b0790-d533-4920-b06c-3c0f6b6c7612'));
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(
          'Request failed with status: ${response.statusCode}, ${response.reasonPhrase}');
      print('Response body: ${await response.stream.bytesToString()}');
    }
  } catch (e) {
    print('Error making the request: $e');
  }
}

import 'package:http/http.dart' as http;

void main() async {
  var headers = {
    'Ocp-Apim-Subscription-Key': 'da9274fa8bdb4272b659c8a30e5372f2',
    'Authorization':
        'Basic M2IzYjA3OTAtZDUzMy00OTIwLWIwNmMtM2MwZjZiNmM3NjEyOmEzNzQ1M2NjOTRhMTRlNmJiZDg1YWE1MjY2ZDJmYjgz',
  };
  var request = http.Request('POST',
      Uri.parse('https://sandbox.momodeveloper.mtn.com/collection/token/'));
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

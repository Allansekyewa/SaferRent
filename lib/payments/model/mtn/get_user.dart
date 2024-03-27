import 'package:http/http.dart' as http;

void main() async {
  var headers = {
    'Ocp-Apim-Subscription-Key': 'da9274fa8bdb4272b659c8a30e5372f2',
    'Authorization':
        'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSMjU2In0.eyJjbGllbnRJZCI6IjNiM2IwNzkwLWQ1MzMtNDkyMC1iMDZjLTNjMGY2YjZjNzYxMiIsImV4cGlyZXMiOiIyMDIzLTExLTEzVDEzOjUyOjM0LjM5MCIsInNlc3Npb25JZCI6ImQyMWJjMWRhLWY4Y2ItNGZhMi04MzU5LTgxMWY3YjljMzA3MiJ9.A5c7rELay32uTBmxYibIclmzRDwxeQs59p91FtS8NJeXHXDeobMzST4RoIyZ5g1y6pTFZfpLldVDjPDXYjoeJKhcC7ara_7C1oANcU4w1_cCI9wiNVOoOwg-EjNVK2cDTlbGl6D93A5dcMsxdUDTKXzLITIVZth8K7UaqwAb5rBwAvZXLIgpIpXcOEG362mbyPhI6ZLZeFcHQraVaVBaphIR2-xeVTShyo9YLNPo_e9-rfoym7txUDoyptwd1fLVKxQy-xcnzKWn07eiauug-jo9bDLsZzvkjSjRmAAKygWdlhyUwOoZdXXRGxBzxOzl_IG8YTSloWcFelJYsqSfNg'
  };
  var request = http.Request(
      'POST',
      Uri.parse(
          'https://sandbox.momodeveloper.mtn.com/v1_0/apiuser/3b3b0790-d533-4920-b06c-3c0f6b6c7612/apikey'));
  request.headers.addAll(headers);

  try {
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      (await response.stream.bytesToString());
    } else {
      ('Request failed with status: ${response.statusCode}, ${response.reasonPhrase}');
    }
  } catch (e) {
    ('Error making the request: $e');
  }
}

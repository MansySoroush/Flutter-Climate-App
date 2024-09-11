import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper({required this.uri});

  final String uri;

  Future getData() async {
    try {
      final uriObject = Uri.parse(uri);
      http.Response response = await http.get(uriObject);

      if (response.statusCode == 200) {
        String data = response.body;

        return jsonDecode(data);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
}

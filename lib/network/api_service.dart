import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      final body = json.decode(response.body);
      return body;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/Admin.dart';

class ApiService {
  Future<List<dynamic>> fetchData(String tableName) async {
    final String baseUrl = await 'http://localhost/petition/api/$tableName.php';

    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final records = data['records'];

      return records;
    } else {
      throw Exception('Faild to Load Data');
    }
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petition/models/Petition.dart';

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

  Future<void> sendPetition(Petition petition, String tableName) async {
    final String baseUrl = await 'http://localhost/petition/api/$tableName.php';

    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(petition.toJson()),
    );
    if (response.statusCode == 201)
    {
      print('Petition Created Successfully');
    } else {
      print(response.statusCode.toString());
      throw Exception('Faild to Create Petition');
    }
  }


}

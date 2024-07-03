import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petition/models/Faculty.dart';
import 'package:petition/models/Petition.dart';


class ApiService {
  Future fetchData(String tableName) async {
    final String baseUrl = await 'http://localhost/petition/api/$tableName.php';

    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final records = data['records'];

      return records;
    }if(response.statusCode==404){
    Map noData= {
      'Response':'No Data Found In Database',
      'Resonse Code ':'404'
    };

     return noData;

    }
    else {
      throw Exception('Faild to Load Data status Code ${response.statusCode}');

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
  Future<void> sendFaculty(FacultyModel faculty, String tableName) async {

    final String baseUrl = await 'http://localhost/petition/api/$tableName.php';

    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(faculty.toJson()),
    );
    if (response.statusCode ==  201)
    {
      print('Faculty added Successfully in database');
    }else if(response.statusCode==400){

      print('Error Data is Incomplete');
    }

    else {
      throw Exception('Faild to add Faculty in Database'+response.statusCode.toString());
    }
  }


}

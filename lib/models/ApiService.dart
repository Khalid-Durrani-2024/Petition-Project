import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petition/models/Faculty.dart';
import 'package:petition/models/Petition.dart';
import 'package:petition/models/UniversityModel.dart';


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
  Future<Map<String,String>> deleteData(String tableName,int id) async {

    final String baseUrl = 'http://localhost/petition/api/universities.php';

    final response = await http.delete(
        Uri.parse(baseUrl),
        headers: {'Content-Type':'application/json'},
        body: json.encode({'id':id})
    );
    if (response.statusCode == 200) {

        return {
          'Message':'Data Deleted',
          'Response Code':response.statusCode.toString()
        };
    }if(response.statusCode==503){

      return {
        'Message':'Unble To Delete Record',
        'Response Code':response.statusCode.toString()
      };

    }
    else {
      throw Exception('Faild Delete Record Response COde is: ${response.statusCode}');

    }
  }

  Future updateUniversity(int id,String name,String location,created_at)async{
    final String baseUrl = await 'http://localhost/petition/api/universities.php';


    final response = await http.put(
      Uri.parse(baseUrl),
      body: json.encode({
        'id':id,
        'name':name,
        'location':location,
        'created_at':created_at
      }),
    );
    if (response.statusCode == 200)
    {
      return {
       'message': 'Updated Record  Successfully',
        'response Code':response.statusCode
      };
    } else {
      print('Faild Response Code: ${response.statusCode} message: ${response.body}');
      throw Exception('Faild to َUpdate University');
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
      print('Faild Response Code: ${response.statusCode} message: ${response.body}');
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


  Future sendUniversity(UniversityModel university, String tableName) async {

    final String baseUrl = await 'http://localhost/petition/api/$tableName.php';

    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(university.toJson()),
    );


    if (response.statusCode ==  201)
    {
      print('University added Successfully in database');
      return response.statusCode;
    }else if(response.statusCode==400){

      print('Error Data is Incomplete');
    }

    else {
      throw Exception('Faild to add University in Database'+response.statusCode.toString());
    }
  }
}

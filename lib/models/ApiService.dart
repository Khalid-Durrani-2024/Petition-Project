import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:petition/models/Faculty.dart';
import 'package:petition/models/Petition.dart';
import 'package:petition/models/SignPetitionModel.dart';
import 'package:petition/models/UniversityAdminModel.dart';
import 'package:petition/models/UniversityModel.dart';
import 'package:petition/models/sendToFacultyModel.dart';


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
  //Sampling
  Future fetchDataSpecific(String tableName,String sender) async {

    final response = await http.get(Uri.parse( 'http://localhost/petition/api/$tableName.php ?sender=$sender'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final records = data['records'];
      print(records);
      return records;
    }if(response.statusCode==404){

      return null;
    }
    else {
      throw Exception('Faild to Load Data status Code ${response.statusCode}');
    }
  }

  Future deleteData(String tableName,int id) async {
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
      throw Exception('Faild Delete Record Response Code is: ${response.statusCode}');

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
  Future sendFaculty(FacultyModel faculty, String tableName) async {

    final String baseUrl = await 'http://localhost/petition/api/$tableName.php';

    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(faculty.toJson()),
    );
    if (response.statusCode ==  201)
    {
      print('Faculty added Successfully in database');
      return response.statusCode;
    }else if(response.statusCode==400){

      print('Error Data is Incomplete');
      return response.statusCode;
    }

    else {
      throw Exception('Faild to add Faculty in Database'+response.statusCode.toString());
    }
  }
  //Inserting New Admin For University in users table
 Future sendUAdmin(UniversityAdminModel uAdmin, String tableName) async {
    final String baseUrl = await 'http://localhost/petition/api/$tableName.php';

    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(uAdmin.toJson()),
    );
    if (response.statusCode ==  201)
    {
      print('University Admin added Successfully in database');
      return response.statusCode;
    }else if(response.statusCode==400){

      print('Error Data is Incomplete');
      return response.statusCode;
    }

    else {
      throw Exception('Faild to add University admin in Database'+response.statusCode.toString());
    }
  }

Future sendToFaculty(SendToFacultyModel sendfacultymodel,String tableName)async{

  final String baseUrl = await 'http://localhost/petition/api/$tableName.php';

  final response = await http.post(
    Uri.parse(baseUrl),
    body: jsonEncode(sendfacultymodel.toJson()),
  );


  if (response.statusCode ==  201)
  {
    print('Petition Sended to faculty Successfully in database');
    return response.statusCode;
  }else if(response.statusCode==400){

    print('Error Data is Incomplete');
  }

  else {
    throw Exception('Faild to send petition to faculty in Database'+response.statusCode.toString());
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

  //Signing petition
  Future signPetition(SignPetitionModel signPetition, String tableName) async {

    final String baseUrl = await 'http://localhost/petition/api/$tableName.php';

    final response = await http.post(
      Uri.parse(baseUrl),
      body: jsonEncode(signPetition.toJson()),
    );


    if (response.statusCode ==  201)
    {
      print('Petition Signed Successfully');
      return response.statusCode;
    }else if(response.statusCode==400){

      print('Error Data is Incomplete');
    }

    else {
      throw Exception('Faild to Sign Petition and Store in Database'+response.statusCode.toString());
    }
  }

  Future takeBackup(String tableName)async{
    final String baseUrl = await 'http://localhost/petition/api/$tableName.php';
    final response=await http.post(Uri.parse(baseUrl));
    if(response.statusCode==200){
      return 200;
    }else{
      print(response.body);
      return 404;
    }
  }

}

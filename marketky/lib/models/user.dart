import 'dart:convert';

import 'package:http/http.dart' as http;
//import 'package:marketky/models/my_event.dart';

class User {
  String name;
  String email;  
  String type;
  String password;

  User(this.name, this.email,this.type, this.password);

  Future<Null> fetchUser(String password, String email) async {
    final response = await http.post(
        Uri.parse("http://192.168.100.62:8000/api/login/authenticate"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));

    if (response.statusCode == 200) {
      if (response.body.toString() == 'login failed') {
        name = '';
        this.email = '';
      } else {
        name = fromJson(jsonDecode(response.body)).name;
        this.email = fromJson(jsonDecode(response.body)).email;
      }
    }
  }

  
  /*static Future<User> getDorcas(String nom, String Email) async {
    final response = await http.get(
      Uri.parse("http://127.0.0.1:8000/api/user/dorcas"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load album');
  }*/

  static Future<String> registerUs(String name, String username, String email, 
  String type, String password) async {
    // String nom, String desc, String date, String heure, int nbPlace) async {
    final response =
        await http.post(Uri.parse("http://10.240.1.90:8000/api/user"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'name': '',
              'email': '',
              'type': '',
              'password': '',
              // 'nom_ev': nom,
              // 'desc_ev': desc,
              // 'date_ev': date,
              // 'heure_ev': heure,
              // 'nbre_place': nbPlace,
             
            }));
    print(response.body.toString());
    if (response.statusCode == 200) {
      return response.body.toString();
    }
    throw Exception(
        'Échec de l\'enregistrement de l\'utilisateur avec le statut : ${response.body.toString()}');
  }



  static User fromJson(Map<String, dynamic> donneeBrute) {
    return User(
        donneeBrute['name'], donneeBrute['eEmail'],
        donneeBrute['password'], donneeBrute['password']);
  }

  String toString() => '{ name: $name, email: $email}';
}

import 'dart:convert';

import 'package:http/http.dart' as http;

class User {
  String name;
  String email;
  String password;

  User(this.name, this.email, this.password);

  Future<Null> fetchUser(String password, String email) async {
    final response = await http.post(
        Uri.parse("http://192.168.1.66:8000/api/login/authenticate"),
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

  static User fromJson(Map<String, dynamic> donneeBrute) {
    return User(
        donneeBrute['name'], donneeBrute['eEmail'], donneeBrute['password']);
  }

  String toString() => '{ name: $name, email: $email}';
}

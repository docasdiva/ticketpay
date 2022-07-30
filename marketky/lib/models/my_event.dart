import 'package:http/http.dart' as http;
import 'dart:convert';

class MyEvent {
  String nom;
  String desc;
  String date;
  String heure;
  String nbPlace;
  String photo;

  // MyEvent(this.nom, this.desc, this.date, this.heure, this.nbPlace, this.photo);
  MyEvent(this.photo,this.nom, this.desc, this.date, this.heure, this.nbPlace);

  static String helloWorld() => 'Hello world';

  static Future<String> storeEvent(String nom, String desc, String date, String heure, String nbPlace) async {
    // String nom, String desc, String date, String heure, int nbPlace) async {
    final response =
        await http.post(Uri.parse("http://10.240.1.90:8000/api/event"),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'nom_ev': 'nom',
              'desc_ev': 'desc',
              'date_ev': '2222-12-03',
              'heure_ev': '14:46',
              'nbre_place': 46,
              // 'nom_ev': nom,
              // 'desc_ev': desc,
              // 'date_ev': date,
              // 'heure_ev': heure,
              // 'nbre_place': nbPlace,
              'photo_ev':
                  'public/storage/event_image\c083b13a6696b0193fd27d3077393b4e.jpg'
            }));
    print(response.body.toString());
    if (response.statusCode == 200) {
      return response.body.toString();
    }
    throw Exception(
        'Échec de l\'enregistrement de l\'évènement avec le statut : ${response.body.toString()}');
  }
}

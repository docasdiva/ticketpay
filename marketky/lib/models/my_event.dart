//import 'dart:html';

import 'package:http/http.dart' as http;
import 'dart:convert';

class MyEvent {
  String nom;
  String desc;
  String date;
  String heure;
  String nbPlace;
  String photo;

  /*Future<bool> addImage(Map<String, String> body, String filepath) async {
    String addimageUrl = 'public/storage/event_image';
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
    };
  }*/

  MyEvent(this.nom, this.desc, this.date, this.heure, this.nbPlace, this.photo);

  // get rating => null;
  /*MyEvent(
      {this.photo, this.nom, this.desc, this.date, this.heure, this.nbPlace});*/

  static String helloWorld() => 'Hello world';

  String toString() =>
      'Nom: $nom, desc:$desc, date: $date, heure: $heure, nbPlace: $nbPlace, imageLink: $photo';

  static MyEvent fromJson(Map<String, dynamic> rawData) {
    return MyEvent(rawData["nom_ev"], rawData["desc"], rawData["date"],
        rawData["heure"], rawData["nbPlace"], rawData["photo"]);
    
  }

  static Future<String> storeEvent(String nom, String desc, String date,
      String heure, String nbPlace, String filepath) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse("http://192.168.100.62:8000/api/event"));

    request.fields['nom_ev'] = nom;
    request.fields['desc_ev'] = desc;
    request.fields['date_ev'] = date;
    request.fields['heure_ev'] = heure;
    request.fields['nbre_place'] = nbPlace;
    request.fields['photo_ev'] = filepath;

    var pic = await http.MultipartFile.fromPath("photo_ev", filepath);

    request.files.add(pic);
    var response = await request.send();
    print(response.toString());
    if (response.statusCode == 200) {
      return response.toString();
    }
    throw Exception(
        'Échec de l\'enregistrement de l\'évènement avec le statut :');
  }

  /*var request = http.MultipartRequest(
        "POST", Uri.parse("http://10.240.1.90:8000/api/event"));
    //add text fields
    request.fields['nom_ev'] = nom;
    request.fields['desc_ev'] = desc;
    request.fields['date_ev'] = date;
    request.fields['heure_ev'] = heure;
    request.fields['nbre_place'] = nbPlace;
    // request.fields['photo_ev'] = filepath;
    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("file_field", filepath);
    //add multipart to request
    request.files.add(pic);
    var response = await request.send();

    //Get the response from the server
    var responseData = await response.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
  }*/

  static Future<List<MyEvent>> FetchEventData() async {
    List<MyEvent> myEvents = [];
    final response =
        await http.get(Uri.parse("http://192.168.100.62:8000/api/event"));
    if (response.statusCode == 200) {
      for (var rawData in json.decode(response.body)) {
        myEvents.add(fromJson(rawData));
        print(rawData.toString());
      }
      print('À la récupération: ${myEvents.toString()}');
      return myEvents;
    }
    throw Exception("Aucun évènement trouvé");
  }
}

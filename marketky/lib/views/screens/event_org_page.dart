// ignore_for_file: deprecated_member_use

//import 'dart:html';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:marketky/constant/app_color.dart';
import 'package:marketky/models/my_event.dart';
//import 'package:marketky/views/screens/home_page.dart';
import 'package:marketky/views/screens/login_page.dart';
//import 'package:marketky/views/screens/otp_verification_page.dart';

class EventOrgPage extends StatefulWidget {
  @override
  _EventOrgPageState createState() => _EventOrgPageState();
}

class _EventOrgPageState extends State<EventOrgPage> {
  final url = "http://192.168.100.62:8000/api/event";

  DateTime date = DateTime(2022, 12, 01);
  TextEditingController nameController = TextEditingController();
  TextEditingController nomEv = TextEditingController();
  TextEditingController descEv = TextEditingController();
  TextEditingController dateEv = TextEditingController();
  TextEditingController heureEv = TextEditingController();
  TextEditingController nbPlace = TextEditingController();
  MyEvent myEvent = MyEvent("","","","","","");

  String erNom;
  String erDesc;
  String erHeure;
  String nbPla;

  File image;

  final picker = ImagePicker();

  Future choiceImage() async {
    var pickedImage = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedImage != null) {
        image = File(pickedImage.path);
      } else {
        print('Aucune image selectionnée');
      }
    });
  }

  /*Future uploadImage(File image) async {
    final uri = Uri.parse("http://10.240.1.90:8000/api/event");
    var request = http.MultipartRequest('POST', uri);
   /* request.fields['nom'] = nameController.text;
    request.fields['nom_ev'] = nomEv.text;
    request.fields['desc_ev'] = descEv.text;
    request.fields['date_ev'] = dateEv.text;
    request.fields['heure_ev'] = heureEv.text;
    request.fields['nbre_place'] = nbPlace.text;*/
    // request.fields.addAll(body);
    //request.fields['desc'] = descEv.text;
    //request.headers['Authorization'] = "";
    //String filepath = image.path;

    var pic = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(pic);
    var respond = await request.send();

    var responseData = await respond.stream.toBytes();
    var responseString = String.fromCharCodes(responseData);
    print(responseString);
    if (respond.statusCode == 200) {
      print(responseString);
    } else {
      print("Upload Failed");
    }
  }*/

  final formKey = GlobalKey<FormState>();

  Widget _buildImage(File image) => (image == null)
      ? Padding(
          padding: const EdgeInsets.fromLTRB(1, 1, 1, 1),
          child: Icon(
            Icons.add,
            color: Colors.grey,
          ),
        )
      : Text(image.path);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          brightness: Brightness.dark,
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text('CREER UN EVENEMENT',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600)),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset('assets/icons/Arrow-left.svg'),
          ),
        ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width,
          height: 48,
          alignment: Alignment.center,
          child: TextButton(
              child: Text(''),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => LoginPage()));
              },
              style: TextButton.styleFrom(
                primary: AppColor.secondary.withOpacity(0.1),
              )),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 24),
            physics: BouncingScrollPhysics(),
            children: [
              // Section 1 - Header
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 12),
                child: Text(
                  'CREER VOTRE EVENEMENT',
                  style: TextStyle(
                    color: AppColor.secondary,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'poppins',
                    fontSize: 20,
                  ),
                ),
              ),

              IconButton(
                  onPressed: () {
                    choiceImage();
                  },
                  icon: Icon(Icons.camera)),
              Text('choisir une image'),
              Container(
                child: image == null
                    ? Text('aucune image selectionnée')
                    : Image.file(image),
              ),

              Container(
                  child: OutlineButton(
                      onPressed: choiceImage, child: _buildImage(image))),

              SizedBox(height: 16),
              /*RaisedButton(
                onPressed: () {
                  uploadImage(image);
                },
                child: Text('telecharger'),
              ),*/

              // Full Name
              TextFormField(
                autofocus: false,
                controller: nomEv,
                decoration: InputDecoration(
                  hintText: 'Nom évènement ',
                  errorText: erNom,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12),
                    child: SvgPicture.asset('assets/icons/Profile.svg',
                        color: AppColor.primary),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.border, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: AppColor.primarySoft,
                  filled: true,
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'veuillez entrer un nom';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Username
              TextFormField(
                autofocus: false,
                controller: descEv,
                decoration: InputDecoration(
                  hintText: 'Description ',
                  errorText: erDesc,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12),
                    child: SvgPicture.asset('assets/icons/Profile.svg',
                        color: AppColor.primary),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.border, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: AppColor.primarySoft,
                  filled: true,
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'veuillez entrer un texte';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              // Email

              TextFormField(
                autofocus: false,
                controller: dateEv,
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today_rounded),
                  labelText: 'choissisez la date ',
                  errorText: erDesc,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12),
                    child: Text('${date.year}/${date.month}/${date.day}',
                        style: TextStyle(fontSize: 15)),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.border, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: AppColor.primarySoft,
                  filled: true,
                ),
                onTap: () async {
                  DateTime newDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));

                  if (newDate != null)
                    return {
                      setState(() {
                        dateEv.text = DateFormat('aaaa-mm-jj').format(newDate);
                      }),
                    };
                },
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'veuillez entrer un texte';
                  }
                  return null;
                },
              ),

              /*Text('${date.year}/${date.month}/${date.day}',
                  style: TextStyle(fontSize: 15)),
              //SizedBox(height: 16,),

              ElevatedButton(
                
                  child: Text('choisir une date'),
                  onPressed: () async {
                    DateTime newDate = await showDatePicker(
                        context: context,
                        initialDate: date,
                        
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));

                    if (newDate == null) return;
                    setState(() => date = newDate);
                  }),*/

              TextFormField(
                autofocus: false,
                controller: heureEv,
                decoration: InputDecoration(
                  hintText: 'Heure ',
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12),
                    //child: SvgPicture.asset('assets/icons/Profile.svg',
                    //  color: AppColor.primary),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.border, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: AppColor.primarySoft,
                  filled: true,
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'veuillez entrer une heure';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              // Password

              // nombre de place
              TextFormField(
                autofocus: false,
                controller: nbPlace,
                decoration: InputDecoration(
                  hintText: 'Nombre de place ',
                  errorText: nbPla,
                  prefixIcon: Container(
                    padding: EdgeInsets.all(12),
                    //  child: SvgPicture.asset('assets/icons/Profile.svg',
                    //   color: AppColor.primary),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.border, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColor.primary, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  fillColor: AppColor.primarySoft,
                  filled: true,
                ),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'veuillez entrer un nombre';
                  }
                  return null;
                },
              ),

              SizedBox(height: 24),
              // Sign Up Button
              ElevatedButton(
                onPressed: () {
                  /*setState(() {
                MyEvent.storeEvent(nomEv.text, descEv.text, dateEv.text,
                    heureEv.text, nbPlace.text);
              });*/

                  /* if (myEvent.nom != '' && myEvent.desc != '') {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Evènement créé avec succès')));
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              }*/
                  /* if (nomEv == "" ||
                  descEv == "" ||
                  heureEv == "" ||
                  nbPlace == "") {
                erNom = "veuillez entrer un nom";
                erDesc = "veuillez saisir la description";
                erHeure = "veuillez l'heure";
                nbPla = "veuillez entrer un chiffre";
              } else {
                erNom = null;
                erDesc = null;
                erHeure = null;
                nbPla = null;
              }*/
                  /* print(MyEvent.storeEvent(nomEv.text, descEv.text, dateEv.text,
                  heureEv.text, nbPlace.text));*/
                  //Navigator.of(context)
                  //  .push(MaterialPageRoute(builder: (context) => HomePage()));
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save();
                    setState(() {
                      MyEvent.storeEvent(
                        nomEv.text,
                        descEv.text,
                        dateEv.text,
                        heureEv.text,
                        nbPlace.text,
                        image.path 
                        );
                      //uploadImage(image);
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('enregistrement en cours')),
                    );
                  }
                },
                child: Text(
                  'Inscription',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      fontFamily: 'poppins'),
                ),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 36, vertical: 18),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  primary: AppColor.primary,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                ),
              ),

              // SIgn in With Google
            ],
          ),
        ));
  }
}

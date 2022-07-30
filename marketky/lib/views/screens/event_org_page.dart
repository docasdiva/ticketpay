// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:marketky/constant/app_color.dart';
import 'package:marketky/models/my_event.dart';
import 'package:marketky/views/screens/home_page.dart';
import 'package:marketky/views/screens/login_page.dart';
//import 'package:marketky/views/screens/otp_verification_page.dart';

class EventOrgPage extends StatefulWidget {
  @override
  _EventOrgPageState createState() => _EventOrgPageState();
}

class _EventOrgPageState extends State<EventOrgPage> {
    final url = "http://192.168.137.1:8000/api/event";

  DateTime date = DateTime(2022, 12, 01);
  TextEditingController nameController = TextEditingController();
  TextEditingController nomEv = TextEditingController();
  TextEditingController descEv = TextEditingController();
  TextEditingController dateEv = TextEditingController();
  TextEditingController heureEv = TextEditingController();
  TextEditingController nbPlace = TextEditingController();
 MyEvent myEvent = MyEvent("", "", "","","","");


  String erNom;
  String erDesc;
  String erHeure;
  String nbPla;

  File image;
  final picker = ImagePicker();
  Future choiceImage() async {
    var pickedImage = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = File(pickedImage.path);
    });
  }

  Future uploadImage() async {
    final uri = Uri.parse("");
    var request = http.MultipartRequest('POST', uri);
    request.fields['name'] = nameController.text;
    var pic = await http.MultipartFile.fromPath("image", image.path);
    request.files.add(pic);
    var respond = await request.send();
    if (respond.statusCode == 200) {
     // print("Image Uploaded");
    } else {
      print("Upload Failed");
    }
  }

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
      body: ListView(
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

          SizedBox(height: 16),
          RaisedButton(
            onPressed: () {
              uploadImage();
            },
            child: Text('telecharger'),
          ),

          // Full Name
          TextField(
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
          ),
          SizedBox(height: 16),
          // Username
          TextField(
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
          ),
          SizedBox(height: 20),
          // Email

          Text('${date.year}/${date.month}/${date.day}',
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
              }),

          TextField(
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
          ),
          SizedBox(height: 16),
          // Password

          // nombre de place
          TextField(
            autofocus: false,
            controller: nbPlace,
            keyboardType: TextInputType.number,
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
          ),

          SizedBox(height: 24),
          // Sign Up Button
          ElevatedButton(
            onPressed: () {
              setState(() {
                MyEvent.storeEvent(nomEv.text, descEv.text, dateEv.text,
                    heureEv.text, nbPlace.text);
              });

              if (myEvent.nom!=''&& myEvent.desc!='') {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Evènement créé avec succès')));
                    Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomePage()));
              }
              if (nomEv == "" ||
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
              }
              print(MyEvent.storeEvent(nomEv.text, descEv.text, dateEv.text,
                  heureEv.text, nbPlace.text));
              //Navigator.of(context)
              //  .push(MaterialPageRoute(builder: (context) => HomePage()));
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
    );
  }
}

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketky/constant/app_color.dart';
import 'package:marketky/models/user.dart';
import 'package:marketky/views/screens/home_page.dart';
import 'package:marketky/views/screens/login_page.dart';
//import 'package:marketky/views/screens/otp_verification_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  TextEditingController nomUs = TextEditingController();
  TextEditingController usernUs = TextEditingController();
  TextEditingController emailUs = TextEditingController();
  TextEditingController typeUs = TextEditingController();
  TextEditingController passwordUs = TextEditingController();
  TextEditingController repUs = TextEditingController();
  User user = User("", "", "", "");

  final formUsKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('inscription',
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
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
          },
          style: TextButton.styleFrom(
            primary: AppColor.secondary.withOpacity(0.1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'vous avez deja un compte?',
                style: TextStyle(
                  color: AppColor.secondary.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                ' se connecter',
                style: TextStyle(
                  color: AppColor.primary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
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
              'Bienvenue sur TicketPay  👋',
              style: TextStyle(
                color: AppColor.secondary,
                fontWeight: FontWeight.w700,
                fontFamily: 'poppins',
                fontSize: 20,
              ),
            ),
          ),

          // Full Name
          TextFormField(
            autofocus: false,
            controller: nomUs,
            decoration: InputDecoration(
              hintText: 'Nom',
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
                return 'veuillez entrer un votre nom';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          // Username

          // Email
          TextFormField(
            autofocus: false,
            controller: emailUs,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: 'email@email.com',
              prefixIcon: Container(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Message.svg',
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
                return 'veuillez entrer un email';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          TextFormField(
            autofocus: false,
            controller: typeUs,
            decoration: InputDecoration(
              hintText: 'Type',
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
                return 'veuillez choisir votre type';
              }
              return null;
            },
          ),

          // Password
          TextFormField(
            autofocus: false,
            obscureText: true,
            controller: passwordUs,
            decoration: InputDecoration(
              hintText: 'Mot de passe',
              prefixIcon: Container(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Lock.svg',
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
              //
              suffixIcon: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/Hide.svg',
                    color: AppColor.primary),
              ),
            ),
            validator: (String value) {
              if (value.length < 6) {
                return 'le mot de passe doit avoir au moins 6caractères';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          // Repeat Password
          TextFormField(
            autofocus: false,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Repeter mot de passe',
              prefixIcon: Container(
                padding: EdgeInsets.all(12),
                child: SvgPicture.asset('assets/icons/Lock.svg',
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
              //
              suffixIcon: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/Hide.svg',
                    color: AppColor.primary),
              ),
            ),
          ),
          SizedBox(height: 24),
          // Sign Up Button
          ElevatedButton(
            onPressed: () {
              if (formUsKey.currentState.validate()) {
                formUsKey.currentState.save();
                setState(() {
                  User.registerUs(nomUs.text, usernUs.text, emailUs.text,
                      typeUs.text, passwordUs.text);
                });
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
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
          
          
        ],
      ),
    );
  }
}

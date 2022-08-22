// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:marketky/constant.dart';
import 'package:marketky/constant/app_color.dart';
import 'package:marketky/models/user.dart';
import 'package:marketky/views/screens/page_switcher.dart';
import 'package:marketky/views/screens/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final url = "http://192.168.100.62:8000/api/user/dorcas";
  final formKey = GlobalKey<FormState>();
  String errorPassword;
  String errorEmail;
  User user = User("","", "","");

  TextEditingController ctrl1 = TextEditingController();
  TextEditingController ctrl2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Se connecter',
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
                .push(MaterialPageRoute(builder: (context) => RegisterPage()));
          },
          style: TextButton.styleFrom(
            primary: AppColor.secondary.withOpacity(0.1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Vous n"avez pas un compte?',
                style: TextStyle(
                  color: AppColor.secondary.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                ' Inscription',
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
              'Bienvenue! 😁',
              style: TextStyle(
                color: AppColor.secondary,
                fontWeight: FontWeight.w700,
                fontFamily: 'poppins',
                fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 32),
            child: Text(
              ' ',
              style: TextStyle(
                  color: AppColor.secondary.withOpacity(0.7),
                  fontSize: 12,
                  height: 150 / 100),
            ),
          ),
          // Section 2 - Form
        /*  TextFormField(
            // The validator receives the text that the user has entered.

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),*/
          // Email
          TextField(
            autofocus: false,
            controller: ctrl1,
            decoration: InputDecoration(
              hintText: 'email@email.com',
              errorText: errorEmail,
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
          ),
          kSpace,
          // Password
          TextField(
            autofocus: false,
            controller: ctrl2,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Mot de passe',
              errorText: errorPassword,
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
          kSpace,
          TextField(
            autofocus: false,
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
          ),
          // Forgot Passowrd
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Mot de passe oublié ?',
                style: TextStyle(
                    fontSize: 12,
                    color: AppColor.secondary.withOpacity(0.5),
                    fontWeight: FontWeight.w700),
              ),
              style: TextButton.styleFrom(
                primary: AppColor.primary.withOpacity(0.1),
              ),
            ),
          ),
          // Sign In button
          ElevatedButton(
            onPressed: () {
              setState(() {
                user.fetchUser(ctrl2.text, ctrl1.text);
              });
              if (user.email != '' && user.name != '') {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => PageSwitcher()));
              } else {
                errorEmail = "email non valide";
                print('email non valde');
              }
              if (ctrl2.text.length < 5) {
                errorPassword =
                    "me mot de passe doit avoir 5caractères au moins";
              } else {
                errorPassword = null;
              }
            },
            child: Text(
              'Connexion',
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

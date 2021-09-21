import 'dart:convert';

import 'package:crush/Constants/constants.dart';
import 'package:crush/Screens/signinScreen.dart';
import 'package:crush/Services/sendnotification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  _splashScreenState createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen> {
  late FirebaseMessaging messaging;
  late Future send;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appThemeColor,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'Crush',
                      style: TextStyle(
                        fontFamily: 'PlaylistScript',
                        fontSize: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Center(
                    child: Text('Date with Stranger,\nMake New Friends',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontFamily: 'SegoeUI',
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.37,
                  ),
                  commonBtn(
                    bgcolor: Colors.white,
                    s: 'Let\'s Get Started',
                    onPressed: () {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => signInScreen()));
                      });
                    },
                    textColor: appThemeColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';

import 'package:crush/Constants/constants.dart';
import 'package:crush/Screens/generalHomeScreen.dart';
import 'package:crush/Screens/homePg.dart';
import 'package:crush/Screens/signinScreen.dart';
import 'package:crush/Services/generatechannelservices.dart';
import 'package:crush/Services/sendnotification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../firebase_notification_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  isloggedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phonenumber = prefs.getString('phonenumber');
    print(phonenumber);
    String? user_id = prefs.getString('user_id');
    print(user_id);
    print(phonenumber.toString());
    (phonenumber == null && user_id == null)
        ? Navigator.push(
            context, CupertinoPageRoute(builder: (_) => SignInScreen()))
        : Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => GeneralHomeScreen(user_id: user_id)));
  }

  @override
  void initState() {
    // TODO: implement initState
    FirebaseNotifications().setupFirebase(context);
    super.initState();
  }

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
                        isloggedin();
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

//   List Data = [];
// Future get() async {
//   var response = await http.post(
//     Uri.parse(
//         'https://g.tenor.com/v1/search?q=funny%20cat&key=780X74Y20AF8&limit=100'),
//   );
//   var Response = jsonDecode(response.body);
//   setState(() {
//     Data = Response['results'];
//   });
//
//   print(Data.length);
//   print(Data);
// }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     get();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GridView.builder(
//         gridDelegate:
//             SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
//         itemBuilder: (context, index) {
//           return Container(
//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: NetworkImage(
//                         Data[index]['media'][0]['nanogif']['url']))),
//           );
//         },
//         itemCount: Data.length,
//       ),
//     );
//   }
// }

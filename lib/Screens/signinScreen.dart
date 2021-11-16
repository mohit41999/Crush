import 'package:crush/Constants/constants.dart';
import 'package:crush/Screens/verifyNumberPg.dart';
import 'package:crush/widgets/backgroundcontainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          backgroundContainer(),
          Container(
            color: Colors.white60.withOpacity(0.6),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Center(
                      child: Text(
                        'Crush',
                        style: TextStyle(
                          fontSize: 70,
                          color: appThemeColor,
                          fontFamily: 'PlaylistScript',
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Sign in to continue',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontFamily: 'SegoeUI',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  commonBtn(
                    bgcolor: Colors.white,
                    s: 'Use Phone Number',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (_) => VerifyNumberPg()));
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

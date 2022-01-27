import 'dart:convert';
import 'dart:io';

import 'package:crush/Constants/constants.dart';
import 'package:crush/Screens/buildUrProfilePg.dart';
import 'package:crush/Screens/generalHomeScreen.dart';
import 'package:crush/Screens/verifyNumberPg.dart';
import 'package:crush/Services/fcmServices.dart';
import 'package:crush/util/App_constants/appconstants.dart';
import 'package:crush/widgets/backgroundcontainer.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'enterCodePg.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  late FirebaseMessaging _getfcmtoken;
  Future fbsignini() async {
    final fb = FacebookLogin();
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    final AuthCredential credential =
        FacebookAuthProvider.credential(res.accessToken!.token);
    final UserCredential user = await _auth.signInWithCredential(credential);

    print(user.user!.email);
    print(
        user.user!.phoneNumber.toString() + '==========================>>>>>>');

    switch (res.status) {
      case FacebookLoginStatus.success:
        // Logged in
        final profile = await fb.getUserProfile();
        print('Hello, ${profile!.name}! You ID: ${profile.userId}');

        AUTHUSER(context, profile.userId, true);
        // Send access token to server for validation and auth
        final FacebookAccessToken? accessToken = res.accessToken;
        print('Access token: ${accessToken!.token}');

        // Get profile data

        // Get user profile image url
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');

        // Get email (since we request email permission)
        final email = await fb.getUserEmail();

        // But user can decline permission
        if (email != null) print('And your email is $email');

        break;
      case FacebookLoginStatus.cancel:
        // User cancel log in
        break;
      case FacebookLoginStatus.error:
        // Log in failed
        print('Error while log in: ${res.error}');
        break;
    }
  }

  Future AUTHUSER(BuildContext context, String auth_id, bool isFacebook) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFacebook', isFacebook);
    var response = await http.post(
        Uri.parse(BASE_URL + AppConstants.LOGIN_WITH_AUTH),
        body: {'token': Token, 'auth_id': auth_id});
    var APIRESPONSE = jsonDecode(response.body);
    print(APIRESPONSE);
    var status = APIRESPONSE['status'];
    var d = APIRESPONSE['data'];
    print('aaaa$status');
    print('aaaa$d');

    prefs.setString('user_id', APIRESPONSE['data']['user_id']);
    _getfcmtoken = FirebaseMessaging.instance;

    _getfcmtoken.getToken().then((value) {
      Fcm_Services().sendfcm(APIRESPONSE['data']['user_id'], value!);
    });

    (APIRESPONSE['status'])
        ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) =>
                    BuildUrProfilePg(user_id: APIRESPONSE['data']['user_id'])))
        : Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => GeneralHomeScreen(
                    user_id: APIRESPONSE['data']['user_id'])));
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );
  Future<void> _handleSignIn() async {
    try {
      // await _googleSignIn.signIn();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      prefs.setString('email', googleSignInAccount.email);
      prefs.setString('displayName', googleSignInAccount.displayName!);
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      var authResult = await _auth.signInWithCredential(credential);
      var _user = authResult.user;
      print(_user!.phoneNumber.toString() + 'pppppppp');
      print(_user.uid.toString() + 'pppppppp');
      AUTHUSER(context, _googleSignIn.currentUser!.id, false);
    } catch (error) {
      print(error);
    }
  }

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
                    isIcon: true,
                    IconColor: Colors.red,
                    Icondata: FontAwesomeIcons.google,
                    bgcolor: Colors.white,
                    s: 'Login with Google',
                    onPressed: () {
                      _handleSignIn();
                    },
                    textColor: appThemeColor,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  commonBtn(
                    isIcon: true,
                    Icondata: FontAwesomeIcons.facebook,
                    IconColor: Color(0xff4267B2),
                    bgcolor: Colors.white,
                    s: 'Sign In with Facebook',
                    onPressed: () {
                      fbsignini();
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (_) => VerifyNumberPg()));
                    },
                    textColor: appThemeColor,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  // commonBtn(
                  //   bgcolor: Colors.white,
                  //   s: 'Use Phone Number',
                  //   onPressed: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (_) => VerifyNumberPg()));
                  //   },
                  //   textColor: appThemeColor,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

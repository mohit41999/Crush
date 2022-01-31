import 'package:crush/Constants/constants.dart';
import 'package:crush/Screens/generalHomeScreen.dart';
import 'package:crush/Screens/signinScreen.dart';
import 'package:crush/Screens/userPg.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../firebase_notification_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  isloggedin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var phonenumber = prefs.getString('phonenumber');
    var otpverify = prefs.getString('otpverify');
    print(otpverify.toString() + 'otpverify');
    print(phonenumber);
    String? user_id = prefs.getString('user_id');
    print(user_id);
    print(phonenumber.toString());
    (user_id == null)
        ? Navigator.push(
            context, CupertinoPageRoute(builder: (_) => SignInScreen()))
        : Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => GeneralHomeScreen(user_id: user_id)));
    // builder: (_) => SignInScreen()));
  }

  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deeplink = dynamicLink?.link;
      if (deeplink != null) {
        print(deeplink.queryParameters.toString());
        var id = deeplink.queryParameters['userid'];
        var invite = deeplink.queryParameters['isInvite'];
        print(id);
        print(invite.toString() + 'pppppppppppp');
        print(deeplink.toString() + 'sssssssssssssssssss');
        SharedPreferences prefs = await SharedPreferences.getInstance();

        String? user_id = prefs.getString('user_id');
        print(user_id);

        (user_id == id)
            ? print('noooo')
            : (user_id == null)
                ? (invite.toString() == 'true')
                    ? Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (_) => SignInScreen(
                                  invited: true,
                                  referal_id: id,
                                )))
                    : Navigator.push(context,
                        CupertinoPageRoute(builder: (_) => SignInScreen()))
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => UserPg(
                              user_id: user_id,
                              selected_user_id: id.toString(),
                              homeuser: true,
                            )));
        print(deeplink.toString());
      }
    }, onError: (OnLinkErrorException e) async {
      print(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    FirebaseNotifications().setupFirebase(context);
    initDynamicLinks();
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

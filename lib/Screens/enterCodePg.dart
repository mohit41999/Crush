import 'dart:convert';

import 'package:crush/Constants/constants.dart';
import 'package:crush/Services/fcmServices.dart';
import 'package:crush/util/App_constants/appconstants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;

import '../firebase_notification_handler.dart';
import 'buildUrProfilePg.dart';
import 'generalHomeScreen.dart';

class enterCodePg extends StatefulWidget {
  final String mobileNumber;
  final bool exists;
  final String user_id;
  const enterCodePg(
      {Key? key,
      required this.mobileNumber,
      required this.user_id,
      required this.exists})
      : super(key: key);

  @override
  _enterCodePgState createState() => _enterCodePgState();
}

class _enterCodePgState extends State<enterCodePg> {
  Future verifyOtp() async {
    var Response = await http
        .post(Uri.parse(BASE_URL + AppConstants.VERIFY_OTP), body: {
      'token': '123456789',
      'mobile_number': widget.mobileNumber,
      'otp': OTP
    });
    var response = jsonDecode(Response.body);
    print(response['status']);
    if (!widget.exists) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => generalHomeScreen(
                    user_id: widget.user_id,
                  )));
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => buildUrProfilePg(
                    user_id: widget.user_id,
                  )));
    }
  }

  TextEditingController otpController = TextEditingController();
  late String OTP;
  late FirebaseMessaging _getfcmtoken;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getfcmtoken = FirebaseMessaging.instance;
    FirebaseNotifications().setupFirebase(context, widget.user_id);
    _getfcmtoken.getToken().then((value) {
      Fcm_Services().sendfcm(widget.user_id, value!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      'Enter Your Code ',
                      style: TextStyle(
                        color: appThemeColor,
                        fontSize: 40,
                        fontFamily: 'SegoeUI',
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Enter 4-digit code',
                      style: TextStyle(
                        color: Color(0xff0B0D0F),
                        fontSize: 16,
                        fontFamily: 'SegoeUI',
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: PinCodeTextField(
                        onChanged: (value) {
                          setState(() {
                            value = otpController.text.toString();
                            OTP = value;
                            print(value);
                          });
                        },
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontFamily: 'SegoeUI',
                          letterSpacing: 1,
                          fontWeight: FontWeight.w600,
                        ),
                        autoDismissKeyboard: false,
                        pinTheme: PinTheme(
                            inactiveColor: appThemeColor,
                            activeColor: Colors.white,
                            fieldHeight: 70,
                            fieldWidth: 60,
                            activeFillColor: appThemeColor,
                            inactiveFillColor: Colors.white,
                            selectedFillColor: appThemeColor,
                            borderWidth: 1,
                            borderRadius: BorderRadius.circular(5),
                            shape: PinCodeFieldShape.box,
                            selectedColor: Colors.white),
                        onSubmitted: (value) {
                          setState(() {
                            value = otpController.text.toString();
                            OTP = value;
                            print(value);
                          });
                        },
                        appContext: context,
                        length: 4,
                        enableActiveFill: true,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Center(
              child: commonBtn(
                  s: 'Continue  ',
                  bgcolor: appThemeColor,
                  textColor: Colors.white,
                  onPressed: () {
                    setState(() {
                      verifyOtp();
                    });
                  }),
            )
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:crush/Constants/constants.dart';
import 'package:crush/Services/sendnotification.dart';
import 'package:crush/util/App_constants/appconstants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'enterCodePg.dart';

class verifyNumberPg extends StatefulWidget {
  const verifyNumberPg({Key? key}) : super(key: key);

  @override
  _verifyNumberPgState createState() => _verifyNumberPgState();
}

class _verifyNumberPgState extends State<verifyNumberPg> {
  late String mobile_number;
  late bool status;
  Future postmobilenumber() async {
    phonenumber = mobile_number.toString();
    var response = await http.post(
        Uri.parse(BASE_URL + AppConstants.LOGIN_WITH_MOBILE_URL),
        body: {'token': '123456789', 'mobile_number': mobile_number});
    var APIRESPONSE = jsonDecode(response.body);
    print(APIRESPONSE);
    status = APIRESPONSE['status'];
    var d = APIRESPONSE['data'];
    print('aaaa$status');
    print('aaaa$d');
    (APIRESPONSE['status'])
        ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => enterCodePg(
                      mobileNumber: mobile_number,
                      user_id: APIRESPONSE['data'],
                      exists: APIRESPONSE['status'],
                    )))
        : Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => enterCodePg(
                      mobileNumber: mobile_number,
                      user_id: APIRESPONSE['data']['user_id'],
                      exists: APIRESPONSE['status'],
                    )));
  }

  TextEditingController mobileNumbercontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 106,
                width: 225,
                child: Text(
                  'What\'s Your Number?',
                  style: TextStyle(
                    fontSize: 40,
                    color: appThemeColor,
                    fontFamily: 'SegoeUI',
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.09,
                child: Text(
                  'Please enter your valid number. We will send you 4-digit code to verify your account.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff0B0D0F),
                    fontFamily: 'SegoeUI',
                    letterSpacing: 1,
                    fontWeight: FontWeight.w600,
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Row(
              children: [
                // Expanded(
                //   flex: 1,
                //   child: Container(
                //     child: Padding(
                //       padding: const EdgeInsets.all(20.0),
                //       child: TextField(
                //         keyboardType: TextInputType.number,
                //         cursorColor: appThemeColor,
                //         decoration: InputDecoration(
                //           hintText: '+00',
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  flex: 3,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: TextField(
                        controller: mobileNumbercontroller,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: '0000000000',
                        ),
                        onChanged: (value) {
                          setState(() {
                            value = mobileNumbercontroller.text.toString();
                            mobile_number = value.toString();
                          });
                        },
                        onSubmitted: (value) {
                          setState(() {
                            value = mobileNumbercontroller.text.toString();
                            mobile_number = value.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            commonBtn(
              bgcolor: appThemeColor,
              s: 'Continue',
              onPressed: () {
                postmobilenumber();
              },
              textColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

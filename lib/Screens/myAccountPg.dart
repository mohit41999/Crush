import 'dart:async';
import 'dart:io';

import 'package:crush/Constants/constants.dart';
import 'package:crush/Model/coinsModel.dart';
import 'package:crush/Model/myAccountModel.dart';
import 'package:crush/Screens/appSettingsPg.dart';
import 'package:crush/Screens/coinsPage.dart';
import 'package:crush/Screens/generalHomeScreen.dart';
import 'package:crush/Screens/inviteFriendsPg.dart';
import 'package:crush/Screens/myPreferencesPg.dart';
import 'package:crush/Screens/myWallet.dart';
import 'package:crush/Services/myAccountService.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class MyAccountPg extends StatefulWidget {
  final String user_id;
  const MyAccountPg({
    Key? key,
    required this.user_id,
  }) : super(key: key);

  @override
  _MyAccountPgState createState() => _MyAccountPgState();
}

class _MyAccountPgState extends State<MyAccountPg> {
  late Future<MyAccount> my_account;
  bool loading = true;
  late MyAccount accountdetails;

  Future _getpostImage() async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var request = http.MultipartRequest(
          "POST",
          Uri.parse(
              "http://crush.notionprojects.tech/api/build_your_profile.php"));
      request.fields['user_id'] = widget.user_id;
      request.fields['token'] = '123456789';
      var pic =
          await http.MultipartFile.fromPath("profile_picture", image.path);
      request.files.add(pic);
      var response = await request.send();

      //Get the response from the server
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print(responseString);
    } else {
      print('image not selected');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    my_account = myAccountService().get_myAccount(widget.user_id).then((value) {
      setState(() {
        accountdetails = value;
        print(accountdetails.data[0].total_coins.toString());
        loading = false;
      });
      return accountdetails;
    });
  }

  FutureOr onGoBack(dynamic value) {
    initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Scaffold(
            body: Center(
                child: Container(width: 100, child: LinearProgressIndicator())))
        : Scaffold(
            body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 25, 15, 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'My Account',
                            style: TextStyle(
                              color: appThemeColor,
                              fontSize: 20,
                              fontFamily: 'SegoeUI',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: 200,
                            height: 40,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => CoinsPg(
                                                      userid: widget.user_id,
                                                      coins: accountdetails
                                                          .data[0].total_coins
                                                          .toString(),
                                                    ))).then((value) {
                                          setState(() {
                                            my_account = myAccountService()
                                                .get_myAccount(widget.user_id)
                                                .then((value) {
                                              setState(() {
                                                accountdetails = value;
                                                print(accountdetails
                                                    .data[0].total_coins
                                                    .toString());
                                                loading = false;
                                              });
                                              return accountdetails;
                                            });
                                          });
                                        });
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        FontAwesomeIcons.coins,
                                        color: Colors.yellow,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: Center(
                                    child: Text(
                                      accountdetails.data[0].total_coins
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        color:
                                            Color(0xff0B0D0F).withOpacity(0.6),
                                        fontFamily: 'SegoeUI',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => MyWalletPg(
                                                      user_id: widget.user_id,
                                                    ))).then((value) {
                                          setState(() {
                                            my_account = myAccountService()
                                                .get_myAccount(widget.user_id)
                                                .then((value) {
                                              setState(() {
                                                accountdetails = value;
                                              });
                                              return accountdetails;
                                            });
                                          });
                                        });
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.account_balance_wallet_rounded,
                                        color: appThemeColor,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                                accountdetails.data[0].profilePicture),
                          ),
                          Positioned(
                            child: GestureDetector(
                              onTap: () {
                                _getpostImage().then((value) {
                                  setState(() {
                                    my_account = myAccountService()
                                        .get_myAccount(widget.user_id)
                                        .then((value) {
                                      setState(() {
                                        accountdetails = value;
                                      });
                                      return accountdetails;
                                    });
                                  });
                                });
                              },
                              child: CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.white,
                                  child: Icon(
                                    Icons.mode_edit_outline_rounded,
                                    size: 20,
                                    color: Colors.black,
                                  )),
                            ),
                            right: 5,
                            top: 85,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        accountdetails.data[0].fullName,
                        style: TextStyle(
                            color: appThemeColor,
                            fontFamily: 'SegoeUI',
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Center(
                      child: SizedBox(
                        height: 40,
                        width: 240,
                        child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        appThemeColor),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ))),
                            onPressed: () {
                              setState(() {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => CoinsPg(
                                              userid: widget.user_id,
                                              coins: accountdetails
                                                  .data[0].total_coins
                                                  .toString(),
                                            ))).then((value) {
                                  setState(() {
                                    my_account = myAccountService()
                                        .get_myAccount(widget.user_id)
                                        .then((value) {
                                      setState(() {
                                        accountdetails = value;
                                        print(accountdetails.data[0].total_coins
                                            .toString());
                                        loading = false;
                                      });
                                      return accountdetails;
                                    });
                                  });
                                });
                              });
                            },
                            child: Center(
                              child: Text(
                                'Select Coins Package for Calls',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyPreferencesPg(
                                        user_id: widget.user_id,
                                        interested:
                                            accountdetails.data[0].interested,
                                      )));
                        });
                      },
                      child: accountPgOptions(
                        icon: Icons.people,
                        title: 'My Preferences',
                        subtitle: 'Choose Who You Like !',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => GeneralHomeScreen(
                                        selectedindex: 1,
                                        user_id: widget.user_id,
                                      )));
                        });
                      },
                      child: accountPgOptions(
                        icon: Icons.favorite,
                        title: 'Favorites',
                        subtitle: 'Call Them Any Time !',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => InviteFriendsPg()));
                        });
                      },
                      child: accountPgOptions(
                        icon: Icons.person_add_alt_1,
                        title: 'Invite Friends',
                        subtitle: 'Invite Your Friends and Earn Coins !',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AppSettingsPg(
                                        user_id: widget.user_id,
                                      )));
                        });
                      },
                      child: accountPgOptions(
                        icon: Icons.settings,
                        title: 'App Settings',
                        subtitle: 'Manage Your Notifications',
                      ),
                    ),
                    accountPgOptions(
                      icon: Icons.help,
                      title: 'Need Help?',
                      subtitle: 'FAQs and Contact',
                    ),
                  ],
                ),
              ),
            ],
          ));
  }
}

class accountPgOptions extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const accountPgOptions(
      {Key? key,
      required this.icon,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: Icon(
        icon,
        color: appThemeColor.withOpacity(0.6),
        size: 30,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Color(0xff0B0D0F).withOpacity(0.8),
          fontSize: 18,
          fontFamily: 'SegoeUI',
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
            color: Color(0xff0B0D0F).withOpacity(0.4),
            fontFamily: 'SegoeUI',
            fontWeight: FontWeight.bold,
            fontSize: 14),
      ),
    );
  }
}

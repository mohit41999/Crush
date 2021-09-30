import 'package:crush/Constants/constants.dart';
import 'package:crush/Model/favourite_profile.dart';
import 'package:crush/Screens/reportUserPg.dart';
import 'package:crush/Services/favourite_profileService.dart';
import 'package:crush/Services/generatechannelservices.dart';
import 'package:crush/Services/sendnotification.dart';
import 'package:flutter/material.dart';

import 'VideoCallPg.dart';
import 'VoiceCall.dart';

class UserPg extends StatefulWidget {
  final String fav_user_id;
  final String? user_id;
  const UserPg({Key? key, required this.fav_user_id, required this.user_id}) : super(key: key);

  @override
  _UserPgState createState() => _UserPgState();
}

class _UserPgState extends State<UserPg> {
  bool loading = true;
  late Future<FavouriteProfile> favourite;
  late FavouriteProfile favourite_user_profile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    favourite = favouriteProfileService()
        .getfavouriteProfile(widget.fav_user_id)
        .then((value) {
      setState(() {
        favourite_user_profile = value;
        loading = false;
      });
      return favourite_user_profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                color: Colors.yellow,
              ),
            ),
          )
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    favourite_user_profile.data[0].fullName,
                    style: TextStyle(
                        color: appThemeColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SegoeUI'),
                  ),
                  Center(
                      child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        favourite_user_profile.data[0].profileImage),
                    radius: 85,
                  )),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              "Age:-",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'SegoeUI',
                                  color: Color(0xff0B0D0F).withOpacity(0.6)),
                            )),
                            Expanded(
                                child: Text(favourite_user_profile.data[0].age,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'SegoeUI',
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff0B0D0F)))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "City:-",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'SegoeUI',
                                  color: Color(0xff0B0D0F).withOpacity(0.6),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Text(favourite_user_profile.data[0].city,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'SegoeUI',
                                        color: Color(0xff0B0D0F)))),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: Text("Interested in:-",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'SegoeUI',
                                        color: Color(0xff0B0D0F)
                                            .withOpacity(0.6)))),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Men",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'SegoeUI',
                                          color: (favourite_user_profile
                                                      .data[0].interested
                                                      .toString() ==
                                                  'men')
                                              ? appThemeColor
                                              : Color(0xff0B0D0F)
                                                  .withOpacity(0.6))),
                                  Text("Women",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'SegoeUI',
                                          color: (favourite_user_profile
                                                      .data[0].interested ==
                                                  'women')
                                              ? appThemeColor
                                              : Color(0xff0B0D0F)
                                                  .withOpacity(0.6))),
                                  Text("Both",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: 'SegoeUI',
                                          color: (favourite_user_profile
                                                      .data[0].interested ==
                                                  'both')
                                              ? appThemeColor
                                              : Color(0xff0B0D0F)
                                                  .withOpacity(0.6))),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          alertbox(context, 'Audio');
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                            size: 40,
                          ),
                          decoration: BoxDecoration(
                              color: appThemeColor,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          alertbox(context, 'Video');
                        },
                        child: Container(
                          height: 70,
                          width: 70,
                          child: Icon(
                            Icons.videocam_rounded,
                            size: 40,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: appThemeColor,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ReportUserPg()));
                      });
                    },
                    child: Center(
                      child: Text(
                        'Report!!!',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: appThemeColor,
                            fontSize: 18,
                            fontFamily: 'SegoeUI'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  void alertbox(BuildContext context, String CallType) {
    showDialog(
        barrierColor: Colors.white.withOpacity(0.4),
        context: context,
        builder: (BuildContext context) => AlertDialog(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: appThemeColor, width: 2),
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        gradient: RadialGradient(
                            colors: [Colors.orange, Colors.yellow]),
                        borderRadius: BorderRadius.circular(50)),
                    child: Icon(
                      Icons.star_rounded,
                      size: 20,
                      color: Colors.yellowAccent.shade100,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        (CallType == 'Audio') ? '4' : '6',
                        style: TextStyle(
                            color: appThemeColor,
                            fontFamily: 'SegoeUI',
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            fontSize: 30),
                      ),
                      Text(
                        ' / min',
                        style: TextStyle(
                            color: Color(0xff0B0D0F).withOpacity(0.8),
                            fontFamily: 'SegoeUI',
                            letterSpacing: 1,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                    ],
                  ),
                  Text(
                    (CallType == 'Audio') ? 'For voice call' : 'For video call',
                    style: TextStyle(
                        color: Color(0xff0B0D0F).withOpacity(0.6),
                        fontFamily: 'SegoeUI',
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  )
                ],
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'SegoeUI',
                                letterSpacing: 1,
                                fontWeight: FontWeight.w600,
                                color: appThemeColor),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        width: 102,
                        decoration: BoxDecoration(
                            color: appThemeColor,
                            borderRadius: BorderRadius.circular(5)),
                        child: FlatButton(
                            onPressed: () {
                              generatechannel().GenerateChannel().then((value) {
                                setState(() {
                                  var cn = value;
                                  print(cn.toString() + '////////////');
                                  sendnotification(

                                      cn,
                                      favourite_user_profile.data[0].fcm_token,
                                      (CallType == 'Audio') ? '1' : '0',widget.user_id,widget.fav_user_id);
                                  (CallType == 'Audio')
                                      ? Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => VoiceCallPg(
                                                    //user_id: widget.user_id,
                                                    channelName: cn,
                                                  )))
                                      : Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VideoCallPage(
                                                    caller_id: widget.fav_user_id,
                                                    user_id: widget.user_id,
                                                    channelName: cn,
                                                    callStatus: 'o',
                                                  )));
                                });
                              });
                            },
                            child: Text(
                              'Ok',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'SegoeUI',
                                  letterSpacing: 1,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            )),
                      ),
                    )
                  ],
                )
              ],
            ));
  }
}

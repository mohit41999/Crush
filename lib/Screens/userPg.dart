import 'package:crush/Constants/constants.dart';
import 'package:crush/Model/favourite_profile.dart';
import 'package:crush/Screens/reportUserPg.dart';
import 'package:crush/Services/favourite_profileService.dart';
import 'package:flutter/material.dart';

class userPg extends StatefulWidget {
  final String fav_user_id;
  const userPg({Key? key, required this.fav_user_id}) : super(key: key);

  @override
  _userPgState createState() => _userPgState();
}

class _userPgState extends State<userPg> {
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
                      Container(
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
                      Container(
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
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => reportuserPg()));
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
}

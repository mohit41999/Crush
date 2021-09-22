import 'dart:convert';
import 'dart:math';

import 'package:crush/Screens/VideoCallPg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class FirebaseNotifications {
  late FirebaseMessaging _firebaseMessaging;

  void setupFirebase(BuildContext context, String user_id) {
    _firebaseMessaging = FirebaseMessaging.instance;
    notificationhandler(context, user_id);
  }

  void notificationhandler(BuildContext context, String user_id) {
    FirebaseMessaging.onMessage.listen((event) {
      String channel_name = event.data['channel_name'];
      print(channel_name + 'inside videocalllllllllllllllllllllll');
      String screenId = event.data['screenId'];
      if (screenId == '0') {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => videoCallPg(
                      user_id: user_id,
                      channelname: event.data['channel_name'],
                    )));
      }
    });
  }
}

import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class FirebaseNotifications {
  late FirebaseMessaging _firebaseMessaging;

  void setupFirebase(BuildContext context) {
    _firebaseMessaging.getToken().then((value) {
      print(value);
    });
    notificationhandler();
  }

  void notificationhandler() {
    FirebaseMessaging.onMessage.listen((event) {
      String channel_name = event.data['channel_name'];
      String screenId = event.data['screenId'];
    });
  }
}

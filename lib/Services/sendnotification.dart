import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future sendnotification(
    String channelname, String token, String screenId) async {
  var Response =
      await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
          body: jsonEncode({
            "registration_ids": [
              token,
            ], //token
            "collapse_key": "type_a",
            "notification": {
              "body": channelname,
              "title": "Title of Your Notification"
            },
            "data": {
              "body": "Body of Your Notification in Data",
              "title": "Title of Your Notification in Title",
              "channel_name": channelname,
              "screenId": screenId
            }
          }),
          encoding: Encoding.getByName("utf-8"),
          headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAATda_6oE:APA91bFRmdzL9GsVLyzfFmUzSoYYsYajrZA12MA6MppKtmfrmUkDoutIhJfKx80zIlajk4LY3a55KcKBefO6LfqY86XJFqQ7s-9If0WpvfUA8LpI4406EMvzH9VuJQiK6KGdcf1Ad5jV'
      });
  var response = jsonDecode(Response.body.toString());
}

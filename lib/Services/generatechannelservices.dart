import 'dart:convert';

import 'package:crush/Constants/constants.dart';
import 'package:crush/util/App_constants/appconstants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class generatechannel {
  Future GenerateChannel(String? user_id) async {
    var response = await http.post(
        Uri.parse(BASE_URL + AppConstants.GENERATECHANNEL),
        body: {'token':Token, 'user_id': user_id});
    var Response = jsonDecode(response.body);

    String channelname = Response['data']['Channel Name'];
    return Response;
  }
}

class CheckBlockUser {
  Future CheckBlock(String? blockid, String user_id) async {
    var response = await http.post(
        Uri.parse(
            'http://crush.notionprojects.tech/api/check_blocked_users.php'),
        body: {
          'token': Token,
          'user_id': user_id,
          'block_user_id': blockid
        });
    var Response = jsonDecode(response.body);
    return Response;
  }
}

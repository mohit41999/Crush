import 'dart:convert';

import 'package:crush/util/App_constants/appconstants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class generatechannel {
  Future GenerateChannel(String? user_id) async {
    var response = await http.post(
        Uri.parse(BASE_URL + AppConstants.GENERATECHANNEL),
        body: {'token': '123456789', 'user_id': user_id});
    var Response = jsonDecode(response.body);

    String channelname = Response['data']['Channel Name'];
    return Response;
  }
}

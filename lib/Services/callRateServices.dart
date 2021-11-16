import 'dart:convert';

import 'package:crush/Constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CallRateServices {
  Map body = {'token': Token};
  Future getAudiorate() async {
    var response = await http.post(
        Uri.parse('https://crush.notionprojects.tech/api/audio_call_rate.php'),
        body: body);
    var Response = jsonDecode(response.body);
    return Response;
  }

  Future getVideorate() async {
    var response = await http.post(
        Uri.parse('https://crush.notionprojects.tech/api/video_call_rate.php'),
        body: body);
    var Response = jsonDecode(response.body);
    return Response;
  }
}

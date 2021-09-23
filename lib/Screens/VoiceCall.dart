import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const APP_ID = '2af01518a23a4f35a6098c9b50467e85';
const Token = '<Your Token>';

class voiceCallPg extends StatefulWidget {
  final String channelname;

  const voiceCallPg({Key? key, required this.channelname}) : super(key: key);
  @override
  _voiceCallPgState createState() => _voiceCallPgState();
}

// App state class
class _voiceCallPgState extends State<voiceCallPg> {
  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Init the app
  Future<void> initPlatformState() async {
    // Get microphone permission
    await [Permission.microphone].request();

    // Create RTC client instance
    RtcEngineContext context = RtcEngineContext(APP_ID);
    var engine = await RtcEngine.createWithContext(context);

    await engine.enableAudio();
    // Define event handling logic
    engine.setEventHandler(RtcEngineEventHandler(
        error: (_) {},
        activeSpeaker: (_) {},
        leaveChannel: (_) {},
        localAudioStateChanged: (_, __) {},
        localVideoStateChanged: (_, __) {},
        remoteAudioStateChanged: (_, __, ___, ____) {},
        remoteVideoStateChanged: (_, __, ___, ____) {},
        tokenPrivilegeWillExpire: (_) {},
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess ${channel} ${uid}');
          setState(() {
            _joined = true;
          });
        },
        userJoined: (int uid, int elapsed) {
          print('userJoined ${uid}');
          setState(() {
            _remoteUid = uid;
          });
        },
        userOffline: (int uid, UserOfflineReason reason) {
          print('userOffline ${uid}');
          setState(() {
            _remoteUid = 0;
          });
        }));
    // Join channel with channel name as 123
    await engine.joinChannel(null, widget.channelname, null, 0);
  }

  // Build chat UI
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agora Audio quickstart',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Agora Audio quickstart'),
        ),
        body: Center(
          child: Text('Please chat!'),
        ),
      ),
    );
  }
}

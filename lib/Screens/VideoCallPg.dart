import 'dart:async';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const APP_ID = '2af01518a23a4f35a6098c9b50467e85';

const Token =
    '0066b462cbcdf254436ab726620f1edb93bIABuntCwp0/RdFu7vSGX7rKs7WOlQcs+nD6NrZ8Fhm5kUbIhF1sAAAAAEAD+bihbwWpMYQEAAQDCakxh';

class videoCallPg extends StatefulWidget {
  final String user_id;
  final String channelname;
  const videoCallPg(
      {Key? key, required this.user_id, required this.channelname})
      : super(key: key);

  @override
  _videoCallPgState createState() => _videoCallPgState();
}

class _videoCallPgState extends State<videoCallPg> {
  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;

  @override
  void initState() {
    print(widget.channelname);
    super.initState();

    initPlatformState();
  }

  Future<void> initPlatformState() async {
    await [Permission.camera, Permission.microphone].request();
    var engine = await RtcEngine.create(APP_ID);
    engine.joinChannel(null, widget.channelname, null, 0);
    await engine.enableVideo();

    // Create RTC client instance

    // RtcEngineContext context = RtcEngineContext(APP_ID);
    //   var engine = await RtcEngine.createWithContext(context);
    // await engine.joinChannel(Token, 'imm', null, 0);
    print('After join channelqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqqq' +
        widget.channelname);
    // Define event handling logic
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
      print('joinChannelSuccess ${channel} ${uid}');
      setState(() {
        _joined = true;
      });
    }, userJoined: (int uid, int elapsed) {
      print('userJoined ${uid}');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline ${uid}');
      setState(() {
        _remoteUid = 0;
      });
    }));
    // Enable video

    // Join channel with channel name as 123
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter ranaca app'),
        ),
        body: Stack(
          children: [
            Center(
              child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _switch = !_switch;
                    });
                  },
                  child: Center(
                    child:
                        _switch ? _renderLocalPreview() : _renderRemoteVideo(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Local preview
  Widget _renderLocalPreview() {
    if (_joined) {
      return RtcLocalView.SurfaceView();
    } else {
      return Text(
        'Please join channel first',
        textAlign: TextAlign.center,
      );
    }
  }

  // Remote preview
  Widget _renderRemoteVideo() {
    if (_remoteUid != 0) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid,
        channelId: widget.channelname,
      );
    } else {
      return Text(
        'Please wait remote user join',
        textAlign: TextAlign.center,
      );
    }
  }
}
// import 'package:flutter/material.dart';
// import 'package:agora_uikit/agora_uikit.dart';
//
//
//
// class videoCallPg extends StatefulWidget {
//   final String user_id;
//   final String channelname;
//
//   const videoCallPg(
//       {Key? key, required this.user_id, required this.channelname})
//       : super(key: key);
//   @override
//   _videoCallPgState createState() => _videoCallPgState();
// }
//
// class _videoCallPgState extends State<videoCallPg> {
//   final AgoraClient client = AgoraClient(
//     agoraConnectionData: AgoraConnectionData(
//       appId: APP_ID,
//       channelName: "test",
//     ),
//     enabledPermission: [
//       Permission.camera,
//       Permission.microphone,
//     ],
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Agora UIKit'),
//           centerTitle: true,
//         ),
//         body: SafeArea(
//           child: Stack(
//             children: [
//               AgoraVideoViewer(
//                 client: client,
//               ),
//               AgoraVideoButtons(
//                 client: client,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

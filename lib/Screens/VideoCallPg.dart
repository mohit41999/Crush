// import 'dart:async';
// //
// // import 'package:agora_rtc_engine/rtc_engine.dart';
// // import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
// // import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// const APP_ID = '2a15c26a752c4cd4844461b23da32c55';
// const Token =
//     '0062a15c26a752c4cd4844461b23da32c55IADmqmm84Z8l2GACFvRoex+IltgK6rxZ2BuaYICedTA8cnfUBg0AAAAAEAC26B3+oQA3YQEAAQChADdh';
//
// class videoCallPg extends StatefulWidget {
//   final String user_id;
//   const videoCallPg({Key? key, required this.user_id}) : super(key: key);
//
//   @override
//   _videoCallPgState createState() => _videoCallPgState();
// }
//
// class _videoCallPgState extends State<videoCallPg> {
//   bool _joined = false;
//   int _remoteUid = 0;
//   bool _switch = false;
//
//   @override
//   void initState() {
//     super.initState();
//     //initPlatformState();
//   }
//
//   // Init the app
//   // Future<void> initPlatformState() async {
//   //   await [Permission.camera, Permission.microphone].request();
//   //
//   //   // Create RTC client instance
//   //   RtcEngineContext context = RtcEngineContext(APP_ID);
//   //   var engine = await RtcEngine.createWithContext(context);
//   //   // Define event handling logic
//   //   engine.setEventHandler(RtcEngineEventHandler(
//   //       joinChannelSuccess: (String channel, int uid, int elapsed) {
//   //     print('joinChannelSuccess ${channel} ${uid}');
//   //     setState(() {
//   //       _joined = true;
//   //     });
//   //   }, userJoined: (int uid, int elapsed) {
//   //     print('userJoined ${uid}');
//   //     setState(() {
//   //       _remoteUid = uid;
//   //     });
//   //   }, userOffline: (int uid, UserOfflineReason reason) {
//   //     print('userOffline ${uid}');
//   //     setState(() {
//   //       _remoteUid = 0;
//   //     });
//   //   }));
//   //   // Enable video
//   //   await engine.enableVideo();
//   //   // Join channel with channel name as 123
//   //   await engine.joinChannel(Token, 'Crush', null, 0);
//   // }
//
//   // Build UI
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Flutter ranaca app'),
//         ),
//         body: Stack(
//           children: [
//             Center(
//               child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
//             ),
//             Align(
//               alignment: Alignment.topLeft,
//               child: Container(
//                 width: 100,
//                 height: 100,
//                 color: Colors.blue,
//                 child: GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _switch = !_switch;
//                     });
//                   },
//                   child: Center(
//                     child:
//                         _switch ? _renderLocalPreview() : _renderRemoteVideo(),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // Local preview
//   Widget _renderLocalPreview() {
//     if (_joined) {
//       return RtcLocalView.SurfaceView();
//     } else {
//       return Text(
//         'Please join channel first',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
//
//   // Remote preview
//   Widget _renderRemoteVideo() {
//     if (_remoteUid != 0) {
//       return RtcRemoteView.SurfaceView(
//         uid: _remoteUid,
//         channelId: "123",
//       );
//     } else {
//       return Text(
//         'Please wait remote user join',
//         textAlign: TextAlign.center,
//       );
//     }
//   }
// }

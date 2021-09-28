import 'dart:async';

import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_uikit/models/agora_settings.dart';
import 'package:agora_uikit/models/agora_user.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

const APP_ID = '2af01518a23a4f35a6098c9b50467e85';

const Token =
    '0066b462cbcdf254436ab726620f1edb93bIABuntCwp0/RdFu7vSGX7rKs7WOlQcs+nD6NrZ8Fhm5kUbIhF1sAAAAAEAD+bihbwWpMYQEAAQDCakxh';

class CallPage extends StatefulWidget {
  final String callType;
  final String channelName;
  const CallPage({Key? key, required this.channelName, required this.callType})
      : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  late DateTime start;
  late DateTime end;
  late String duration;
  late String channelname;
  late AgoraClient client;
  late AgoraUser clients;
  late AgoraSettings settings;
  late Permission camera;
  late final displayTime2;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    onChange: (value) {
      final displayTime = StopWatchTimer.getDisplayTime(value);

      print('displayTime $displayTime');
      print('onChange $value');
    },
  );

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose(); // Need to call dispose function.
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      channelname = widget.channelName;

      initialize(channelname);
    });
  }

  void initialize(String channelname) {
    client = AgoraClient(
      agoraEventHandlers: AgoraEventHandlers.empty().copyWith(
        userJoined: (i, j) {
          setState(() {
            _stopWatchTimer.onExecute.add(StopWatchExecute.start);
            _stopWatchTimer.onChange;
            print(
                'iiiiiiiiiiiiiiiiiiiiiooooooooooooooooooooooooooooooooooooooooooooo');
            start = DateTime.now();
            print('User joined at ${start.toString()}');
          });
        },
        userOffline: (i, j) {
          _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
          end = DateTime.now();
          print('user lest at $end');
          duration = "${end.hour - start.hour}" +
              ":${end.minute - start.minute}" +
              ":${end.second - start.second}";
          print(duration.toString() + '777777777777777777777777777777777777');
        },
      ),
      agoraConnectionData: AgoraConnectionData(
        appId: APP_ID,
        channelName: channelname,
      ),
      enabledPermission: [
        //RtcEngine.instance.muteLocalVideoStream(true)
        Permission.microphone,
        Permission.camera,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Agora UIKit'),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              AgoraVideoViewer(
                layoutType: Layout.floating,
                client: client,
                showAVState: true,
              ),
              Align(
                alignment: Alignment.topRight,
                child: StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: 0,
                  builder: (context, snap) {
                    final value = snap.data;
                    final displayTime = StopWatchTimer.getDisplayTime(value!);
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            displayTime.substring(0, 8),
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Helvetica',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              AgoraVideoButtons(
                client: client,

                // disconnectButtonChild: MaterialButton(
                //   onPressed: () async {
                //     await client.sessionController.endCall();
                //
                //     //client.sessionController.dispose();
                //
                //     Navigator.pop(context);
                //   },
                //   child: Icon(Icons.call_end, color: Colors.white, size: 35),
                //   shape: CircleBorder(),
                //   elevation: 2.0,
                //   color: Colors.redAccent,
                //   padding: const EdgeInsets.all(15.0),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

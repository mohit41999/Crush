import 'package:crush/Screens/VideoCallPg.dart';
import 'package:crush/Screens/VoiceCall.dart';
import "package:flutter/material.dart";

class callIncomingScreen extends StatefulWidget {
  final String channel_name;
  final String Screen_id;
  const callIncomingScreen(
      {Key? key, required this.channel_name, required this.Screen_id})
      : super(key: key);

  @override
  _callIncomingScreenState createState() => _callIncomingScreenState();
}

class _callIncomingScreenState extends State<callIncomingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Incoming VideoCall'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Reject'),
                color: Colors.red,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);
                  (widget.Screen_id == '0')
                      ? Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CallPage(
                                  callType: 'i',
                                  // user_id: widget.user_id,
                                  channelName: widget.channel_name)))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => voiceCallPg(
                                  // user_id: widget.user_id,
                                  channelName: widget.channel_name)));
                },
                color: Colors.green,
                child: Text('Accept'),
              )
            ],
          )
        ],
      ),
    );
  }
}

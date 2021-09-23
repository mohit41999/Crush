import 'package:crush/Screens/VideoCallPg.dart';
import 'package:crush/Screens/VoiceCall.dart';
import "package:flutter/material.dart";

class callIncomingScreen extends StatefulWidget {
  final String user_id;
  final String channel_name;
  const callIncomingScreen(
      {Key? key, required this.user_id, required this.channel_name})
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => voiceCallPg(
                              // user_id: widget.user_id,
                              channelname: widget.channel_name)));
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

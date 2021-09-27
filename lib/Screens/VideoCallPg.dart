import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_uikit/models/agora_settings.dart';
import 'package:agora_uikit/models/agora_user.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const APP_ID = '2af01518a23a4f35a6098c9b50467e85';

const Token =
    '0066b462cbcdf254436ab726620f1edb93bIABuntCwp0/RdFu7vSGX7rKs7WOlQcs+nD6NrZ8Fhm5kUbIhF1sAAAAAEAD+bihbwWpMYQEAAQDCakxh';

class CallPage extends StatefulWidget {
  final String channelName;
  const CallPage({Key? key, required this.channelName}) : super(key: key);

  @override
  _CallPageState createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  late String channelname;
  late AgoraClient client;
  late AgoraUser clients;
  late AgoraSettings settings;
  late Permission camera;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      channelname = widget.channelName;

      // disablecamera();

      initialize(channelname);
    });
  }

  void initialize(String channelname) {
    client = AgoraClient(
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
              AgoraVideoButtons(
                client: client,
                disconnectButtonChild: MaterialButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.call_end, color: Colors.white, size: 35),
                  shape: CircleBorder(),
                  elevation: 2.0,
                  color: Colors.redAccent,
                  padding: const EdgeInsets.all(15.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:crush/Constants/constants.dart';
import 'package:crush/Model/callHistoryModel.dart';
import 'package:crush/Services/callhistoryServices.dart';
import 'package:flutter/material.dart';

class CallHistoryPg extends StatefulWidget {
  final String? user_id;
  const CallHistoryPg({Key? key, required this.user_id}) : super(key: key);

  @override
  _CallHistoryPgState createState() => _CallHistoryPgState();
}

class _CallHistoryPgState extends State<CallHistoryPg> {
  late CallHistoryModel callhistory;
  bool loading = true;
  late Future<CallHistoryModel> ch;

  @override
  void initState() {
    // TODO: implement initState
    ch = CallHistoryServices()
        .get_call_history(user_id: widget.user_id)
        .then((value) {
      setState(() {
        callhistory = value;
        loading = false;
      });
      return callhistory;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (loading)
        ? Scaffold(
            body: Center(
            child: CircularProgressIndicator(),
          ))
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 15),
                    child: Text(
                      'Call History',
                      style: TextStyle(
                        color: appThemeColor,
                        fontSize: 20,
                        fontFamily: 'SegoeUI',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                          reverse: true,
                          shrinkWrap: true,
                          itemCount: callhistory.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                ListTile(
                                  dense: true,
                                  contentPadding: EdgeInsets.all(0),
                                  leading: Icon(
                                    Icons.account_circle_rounded,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                  title: Text(
                                    '${callhistory.data[index].fullName}',
                                    style: TextStyle(
                                      fontFamily: 'SegoeUI',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Row(
                                    children: [
                                      Icon(
                                        (callhistory.data[index].callStatus ==
                                                'Incoming')
                                            ? Icons.south_west
                                            : Icons.north_east,
                                        color: (callhistory
                                                    .data[index].callStatus ==
                                                'Incoming')
                                            ? Color(0xffFF4E4E)
                                            : Color(0xff0FD97B),
                                        size: 15,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8.0, 0, 8),
                                        child: Text('10 Jan, 20:21'),
                                      ),
                                    ],
                                  ),
                                  trailing: Wrap(
                                    spacing: 18, // space between two icons
                                    children: <Widget>[
                                      Text(
                                        '${callhistory.data[index].callDuration}',
                                        // (index == 5 ||
                                        //         index == 10 ||
                                        //         index == 3 ||
                                        //         index == 7)
                                        //     ? 'unblock'
                                        //     : 'Block',
                                        style: TextStyle(
                                            color: Color(0xff0B0D0F)
                                                .withOpacity(0.6),
                                            fontSize: 12,
                                            fontFamily: 'SegoeUI',
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.italic),
                                      ),
                                      // Icon(
                                      //   Icons.block,
                                      //   color: Colors.red,
                                      // ), // icon-1
                                      Icon(
                                        (callhistory.data[index].callType ==
                                                'video')
                                            ? Icons.videocam_rounded
                                            : Icons.call,
                                        color: appThemeColor,
                                      ), // icon-2
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}

import 'package:crush/Constants/constants.dart';
import 'package:flutter/material.dart';


class callHostoryPg extends StatefulWidget {
  final String user_id;
  const callHostoryPg({Key? key, required this.user_id}) : super(key: key);

  @override
  _callHostoryPgState createState() => _callHostoryPgState();
}

class _callHostoryPgState extends State<callHostoryPg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 22,
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
                            'Lorem Ipsum',
                            style: TextStyle(
                              fontFamily: 'SegoeUI',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Icon(
                                (index == 5 ||
                                        index == 10 ||
                                        index == 3 ||
                                        index == 7)
                                    ? Icons.north_east
                                    : Icons.south_west,
                                color: (index == 5 ||
                                        index == 10 ||
                                        index == 3 ||
                                        index == 7)
                                    ? Color(0xff0FD97B)
                                    : Color(0xffFF4E4E),
                                size: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 8.0, 0, 8),
                                child: Text('10 Jan, 20:21'),
                              ),
                            ],
                          ),
                          trailing: Wrap(
                            spacing: 18, // space between two icons
                            children: <Widget>[
                              Text(
                                (index == 5 ||
                                        index == 10 ||
                                        index == 3 ||
                                        index == 7)
                                    ? 'unblock'
                                    : 'Block',
                                style: TextStyle(
                                    color: Color(0xff0B0D0F).withOpacity(0.6),
                                    fontSize: 12,
                                    fontFamily: 'SegoeUI',
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.italic),
                              ),
                              Icon(
                                Icons.block,
                                color: Colors.red,
                              ), // icon-1
                              Icon(
                                (index == 5 ||
                                        index == 10 ||
                                        index == 3 ||
                                        index == 7)
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
            )
          ],
        ),
      ),
    );
  }
}

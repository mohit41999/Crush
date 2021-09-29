import 'package:crush/Constants/constants.dart';
import 'package:flutter/material.dart';

class ReportUserPg extends StatefulWidget {
  const ReportUserPg({Key? key}) : super(key: key);

  @override
  _ReportUserPgState createState() => _ReportUserPgState();
}

class _ReportUserPgState extends State<ReportUserPg> {
  TextStyle reportText =
      TextStyle(color: Color(0xff0B0D0F).withOpacity(0.8), fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Report',
              style: TextStyle(
                  color: appThemeColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text('Why are you reporting this post ?',
                style: TextStyle(fontSize: 16)),
            Text(
              'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea.',
              style: TextStyle(
                  color: Color(0xff0B0D0F).withOpacity(0.6), fontSize: 14),
            ),
            Text(
              'It\'s spam',
              style: reportText,
            ),
            Text(
              'I just don\'t like it',
              style: reportText,
            ),
            Text(
              'Nudity or sexual activity',
              style: reportText,
            ),
            Text(
              'Hate speech or symbols',
              style: reportText,
            ),
            Text(
              'Violence or dangerous organisations',
              style: reportText,
            ),
            Text(
              'False informations',
              style: reportText,
            ),
            Text(
              'Bullying or harassment',
              style: reportText,
            ),
            Text(
              'Scam or fraud',
              style: reportText,
            ),
            Text(
              'Intellectual property violation',
              style: reportText,
            ),
            Text(
              'Suicide or injury',
              style: reportText,
            ),
            Text(
              'Sale of illegal or regulated goods',
              style: reportText,
            ),
            Text(
              'Eating disorder',
              style: reportText,
            ),
            Text(
              'Something else',
              style: reportText,
            )
          ],
        ),
      ),
    );
  }
}

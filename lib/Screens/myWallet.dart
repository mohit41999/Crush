import 'dart:convert';

import 'package:crush/Constants/constants.dart';
import 'package:crush/Screens/WithdrawInr.dart';
import 'package:crush/Screens/razorpay.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyWalletPg extends StatefulWidget {
  const MyWalletPg({
    Key? key,
    required this.user_id,
    required this.coins,
  }) : super(key: key);
  final String? user_id;
  final String coins;
  @override
  _MyWalletPgState createState() => _MyWalletPgState();
}

class _MyWalletPgState extends State<MyWalletPg> {
  late Map commonbody = {'token': Token, 'user_id': widget.user_id};
  late String Money = '';
  List transactionHistory = [];
  Future myWallet() async {
    var response = await http.post(
        Uri.parse('https://crush.notionprojects.tech/api/my_wallet.php'),
        body: commonbody);
    var Response = jsonDecode(response.body);
    if (Response['status'] == true) {
      setState(() {
        Money = Response['data']['Total Balance'];
      });
    }
  }

  Future gettransactionHistory() async {
    var response = await http.post(
        Uri.parse('http://crush.notionprojects.tech/api/payment_history.php'),
        body: commonbody);
    var Response = jsonDecode(response.body);
    if (Response['status'] == true) {
      setState(() {
        transactionHistory = Response['data'];
      });
    }
  }

  String month({required String month}) {
    switch (month) {
      case '01':
        return 'Jan';
      case '02':
        return 'Feb';
      case '03':
        return 'Mar';
      case '04':
        return 'Apr';
      case '05':
        return 'May';
      case '06':
        return 'Jun';
      case '07':
        return 'Jul';
      case '08':
        return 'Aug';
      case '09':
        return 'Sep';
      case '10':
        return 'Oct';
      case '11':
        return 'Nov';
      case '12':
        return 'Dec';
      default:
        return " ";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      myWallet().then((value) {
        gettransactionHistory();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: Text(
              'Transaction History',
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'SegoeUI',
                  fontWeight: FontWeight.w600,
                  color: Color(0xff0B0D0F)),
            )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.09,
              color: appThemeColor,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Date',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'SegoeUI'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Amount',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'SegoeUI'),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Remark',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontFamily: 'SegoeUI'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (transactionHistory.length == 0)
                ? Container()
                : Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          reverse: true,
                          itemCount: transactionHistory.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Center(
                                        child: Text(transactionHistory[index]
                                                    ['date']
                                                .toString()
                                                .substring(8, 10) +
                                            ' ' +
                                            month(
                                                month: transactionHistory[index]
                                                        ['date']
                                                    .toString()
                                                    .substring(5, 7)) +
                                            ' ' +
                                            transactionHistory[index]['date']
                                                .toString()
                                                .substring(0, 4)))),
                                Expanded(
                                    child: Center(
                                        child: Text(
                                  transactionHistory[index]['amount'],
                                  style: TextStyle(
                                      color: (transactionHistory[index]
                                                  ['remark'] ==
                                              'Deposit'
                                          ? Colors.green
                                          : Colors.red),
                                      fontWeight: FontWeight.bold),
                                ))),
                                Expanded(
                                    child: Center(
                                        child: Text(transactionHistory[index]
                                            ['remark']))),
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

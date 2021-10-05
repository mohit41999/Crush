import 'dart:convert';

import 'package:crush/Constants/constants.dart';
import 'package:crush/Screens/razorpay.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyWalletPg extends StatefulWidget {
  const MyWalletPg({
    Key? key,
    required this.user_id,
  }) : super(key: key);
  final String? user_id;
  @override
  _MyWalletPgState createState() => _MyWalletPgState();
}

class _MyWalletPgState extends State<MyWalletPg> {
  late Map commonbody = {'token': '123456789', 'user_id': widget.user_id};
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

  late String coins_amount;
  TextEditingController coins_amountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      myWallet();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'My Wallet',
              style: TextStyle(color: appThemeColor, fontSize: 20),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.2,
            color: appThemeColor,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('INR ${Money.toString()}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Balance',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            width: 118,
                            height: 36,
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RazorPay()));
                                },
                                child: Text(
                                  'Deposit',
                                  style: TextStyle(
                                      color: appThemeColor, fontSize: 14),
                                )),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            width: 118,
                            height: 36,
                            child: TextButton(
                                onPressed: () {},
                                child: Text(
                                  'Withdraw',
                                  style: TextStyle(
                                      color: appThemeColor, fontSize: 14),
                                )),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '0',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'SegoeUI',
                            color: Colors.black),
                      ),
                      Text(
                        'Promo Balance',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'SegoeUI',
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0B0D0F).withOpacity(0.6)),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.info,
                    size: 30,
                    color: Color(0xff0B0D0F),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
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
                  child: ListView.builder(
                      shrinkWrap: true,
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
                                        .substring(0, 10)))),
                            Expanded(
                                child: Center(
                                    child: Text(
                              transactionHistory[index]['amount'],
                              style: TextStyle(
                                  color: (transactionHistory[index]['remark'] ==
                                          'deposit'
                                      ? Colors.green
                                      : Colors.red),
                                  fontWeight: FontWeight.bold),
                            ))),
                            Expanded(
                                child: Center(
                                    child: Text(
                                        transactionHistory[index]['remark']))),
                          ],
                        );
                      }),
                )
        ],
      ),
    );
  }
}

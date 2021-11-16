import 'dart:convert';

import 'package:crush/Constants/constants.dart';
import 'package:crush/Model/coinsModel.dart';
import 'package:crush/Screens/WithdrawInr.dart';
import 'package:crush/Screens/razorpay.dart';
import 'package:crush/Services/coinsServices.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CoinsPg extends StatefulWidget {
  final String? userid;
  final String coins;
  const CoinsPg({
    Key? key,
    required this.userid,
    required this.coins,
  }) : super(key: key);

  @override
  _CoinsPgState createState() => _CoinsPgState();
}

class _CoinsPgState extends State<CoinsPg> {
  List coinsDetails = [];
  String coinrate = '';
  late String CoinsBalance;
  late String INR = '';
  late String withdrawamount;
  bool balncevalidate = false;
  TextEditingController withrawController = TextEditingController();
  Future converttoInr(String coinamount) async {
    var response = await http.post(
        Uri.parse('http://crush.notionprojects.tech/api/coins_convert.php'),
        body: {
          'token': Token,
          'user_id': widget.userid,
          'coins': coinamount,
        });
    var Response = jsonDecode(response.body);
    print(Response['data'].toString() + 'ppppppppp');
    (Response['status'])
        ? INR = Response['data']['total_rupees'].toString()
        : {};
  }

  Future getcoinrate() async {
    var response = await http.post(
        Uri.parse('http://crush.notionprojects.tech/api/coins_rate.php'),
        body: {
          'token': Token,
          'user_id': widget.userid,
        });
    var Response = jsonDecode(response.body);
    print(Response['data'].toString() + 'ppppppppp');
    setState(() {
      coinrate = Response['data']['coinsRate'];
    });
  }
  void getcoindetails() {
    coinsService().getCoins(widget.userid).then((value) {
      setState(() {
        coinsDetails = value.data;
        CoinsBalance = coinsDetails[0].user_total_coins;
        print(CoinsBalance + '1111111111111111');
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CoinsBalance = widget.coins;
    getcoinrate();

    setState(() {
      getcoindetails();
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
              'Coins',
              style: TextStyle(color: appThemeColor, fontSize: 20),
            ),
          ),
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.23,
            color: appThemeColor,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(CoinsBalance,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Coins Balance',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    width: 118,
                    height: 36,
                    child: TextButton(
                        onPressed: () {
                          setState(() {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                      title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Enter Coints Amount to Withdraw ',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                              IconButton(
                                                  padding: EdgeInsets.all(0),
                                                  splashColor: appThemeColor,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  icon: Icon(Icons.close))
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: appThemeColor)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    'Total Coins: ${CoinsBalance}',
                                                    style: TextStyle(
                                                        color: appThemeColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: appThemeColor)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: Text(
                                                    '1\u{20B9} =  $coinrate Coins',
                                                    style: TextStyle(
                                                        color: appThemeColor,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      content: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: withrawController,
                                        onChanged: (value) {
                                          setState(() {
                                            value = withrawController.text
                                                .toString();
                                            withdrawamount = value;
                                          });
                                        },
                                      ),
                                      actions: [
                                        commonBtn(
                                            s: 'Withdraw',
                                            bgcolor: appThemeColor,
                                            textColor: Colors.white,
                                            onPressed: () {
                                              converttoInr(
                                                      withrawController.text)
                                                  .then((value) {
                                                Navigator.pop(context);
                                              });
                                            })
                                      ],
                                    )).then((value) {
                              (withrawController.text.toString() == '')
                                  ? {}
                                  : {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: Text(
                                                    '${withrawController.text.toString()} Coins=$INR Rupees'),
                                                content: Text(
                                                    'Are you sure you want to withdraw $INR'),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      commonBtn(
                                                        height: 40,
                                                        width: 60,
                                                        s: 'No',
                                                        bgcolor: Colors.red,
                                                        textColor: Colors.white,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      commonBtn(
                                                        height: 40,
                                                        width: 60,
                                                        s: 'Yes',
                                                        bgcolor: Colors.green,
                                                        textColor: Colors.white,
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      WithdrawInr(
                                                                        INR:
                                                                            INR,
                                                                      ))).then(
                                                              (value) {
                                                            setState(() {
                                                              getcoindetails();
                                                            });
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ))
                                    };
                            });
                          });
                        },
                        child: Text(
                          'Withdraw',
                          style: TextStyle(color: appThemeColor, fontSize: 14),
                        )),
                  )
                ],
              ),
            )),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 10),
            child: Center(
                child: Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.06,
              //height: 50,
              decoration: BoxDecoration(
                  border: Border.symmetric(
                horizontal: BorderSide(color: Colors.grey),
                vertical: BorderSide(color: Colors.grey),
              )),
              child: Center(
                  child: Text(
                '1\u{20B9} =  $coinrate Coins',
                style: TextStyle(
                    color: Color(0xff0B0D0F).withOpacity(0.4),
                    fontSize: 20,
                    fontFamily: 'SegoeUI'),
              )),
            )),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: coinsDetails.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20.0),
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: appThemeColor)),
                      child: Center(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: 100,
                              height: 40,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        gradient: RadialGradient(colors: [
                                          Colors.orange,
                                          Colors.yellow
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: Icon(
                                      Icons.star_rounded,
                                      size: 20,
                                      color: Colors.yellowAccent.shade100,
                                    ),
                                  ),
                                  Text(
                                    coinsDetails[index].totalCoin,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'SegoeUI',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: SizedBox(
                              width: 90,
                              height: 40,
                              child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              appThemeColor),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ))),
                                  onPressed: () {
                                    setState(() {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: Text(
                                                    'Are you Sure You Want to Add ${coinsDetails[index].amount} Coins'),
                                                actions: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      commonBtn(
                                                        height: 40,
                                                        width: 60,
                                                        s: 'No',
                                                        bgcolor: Colors.red,
                                                        textColor: Colors.white,
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      commonBtn(
                                                        height: 40,
                                                        width: 60,
                                                        s: 'Yes',
                                                        bgcolor: Colors.green,
                                                        textColor: Colors.white,
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      RazorPay(
                                                                        amount:
                                                                            coinsDetails[index].amount,
                                                                      ))).then(
                                                              (value) {
                                                            setState(() {
                                                              getcoindetails();
                                                            });
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  )
                                                ],
                                              )).then((value) {
                                        if (balncevalidate) {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    content: Text(
                                                      'You dont have enough balance to buy coins!!',
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    ),
                                                    actions: [
                                                      commonBtn(
                                                          s: 'Ok ',
                                                          bgcolor:
                                                              appThemeColor,
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                            balncevalidate =
                                                                false;
                                                          })
                                                    ],
                                                  ));
                                        }
                                      });
                                    });
                                  },
                                  child: Text(
                                    '\u{20B9}' + coinsDetails[index].amount,
                                    style: TextStyle(color: Colors.white),
                                  )),
                            ),
                          )
                        ],
                      )),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

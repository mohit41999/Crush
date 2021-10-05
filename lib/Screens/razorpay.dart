import 'dart:convert';
import 'dart:io';

import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RazorPay extends StatefulWidget {
  const RazorPay({Key? key}) : super(key: key);

  @override
  _RazorPayState createState() => _RazorPayState();
}

class _RazorPayState extends State<RazorPay> {
  late Razorpay _razorpay;
  var options = {
    'key': 'rzp_test_bY875AaEn5ufHo',
    'amount': 50000, //in the smallest currency sub-unit.
    'name': 'Acme Corp.',
    'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    'description': 'Fine T-Shirt',
    'timeout': 60, // in seconds
    'prefill': {'contact': '9123456789', 'email': 'gaurav.kumar@example.com'}
  };

  @override
  void dispose() {
    _razorpay.clear();
    // TODO: implement dispose
    super.dispose();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds

    print('order' + response.orderId.toString());
    print('paymentId' + response.paymentId.toString());
    print('signature' + response.signature.toString());
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // TODO: implement initState
    super.initState();
  }

  String username = 'rzp_test_bY875AaEn5ufHo';
  String password = 'We61mrArb2VYTdYXy3dVpOdv';

  TextEditingController payamount = TextEditingController();
  void payment(String amount) async {
    final client = HttpClient();

    final request =
        await client.postUrl(Uri.parse('https://api.razorpay.com/v1/orders'));
    request.headers
        .set(HttpHeaders.contentTypeHeader, "application/json; charset=UTF-8");
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('${username}:${password}'));
    request.headers.set(HttpHeaders.authorizationHeader, basicAuth);
    Object? orderOptions = {
      "amount": amount,
      "currency": "INR",
      "receipt": "Receipt no. 1",
      "payment_capture": 1,
      "notes": {
        "notes_key_1": "Tea, Earl Grey, Hot",
        "notes_key_2": "Tea, Earl Grey… decaf."
      }
    };
    request.add(utf8.encode(json.encode(orderOptions)));
    final response = await request.close();
    response.transform(utf8.decoder).listen((contents) {
      String orderId = contents.split(',')[0].split(":")[1];
      orderId = orderId.substring(1, orderId.length - 1);

      Map<String, dynamic> checkoutOptions = {
        'key': username,
        'amount': amount,
        "currency": "INR",
        'name': 'E Drives',
        'description': 'E Bike',
        'order_id': orderId, // Generate order_id using Orders API
        'timeout': 300,
      };
      try {
        _razorpay.open(checkoutOptions);
      } catch (e) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: payamount,
          ),
          MaterialButton(
            onPressed: () {
              payment(payamount.text.toString());
            },
            child: Text('PAY'),
          ),
        ],
      ),
    );
  }
}

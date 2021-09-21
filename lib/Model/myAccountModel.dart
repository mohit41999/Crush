// To parse this JSON data, do
//
//     final myAccount = myAccountFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

MyAccount myAccountFromJson(String str) => MyAccount.fromJson(json.decode(str));

String myAccountToJson(MyAccount data) => json.encode(data.toJson());

class MyAccount {
  MyAccount({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory MyAccount.fromJson(Map<String, dynamic> json) => MyAccount(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.fullName,
    required this.profilePicture,
    required this.total_coins,
    required this.interested,
  });

  String id;
  String fullName;
  String profilePicture;
  dynamic total_coins;
  String interested;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        fullName: json["full_name"],
        profilePicture: json["profile_picture"],
        total_coins: json["total_coins"],
        interested: json["interested"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "profile_picture": profilePicture,
        "total_coins": total_coins,
        "interested": interested,
      };
}

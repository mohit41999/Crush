// To parse this JSON data, do
//
//     final favouriteProfile = favouriteProfileFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FavouriteProfile favouriteProfileFromJson(String str) =>
    FavouriteProfile.fromJson(json.decode(str));

String favouriteProfileToJson(FavouriteProfile data) =>
    json.encode(data.toJson());

class FavouriteProfile {
  FavouriteProfile({
    required this.status,
    required this.message,
    required this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory FavouriteProfile.fromJson(Map<String, dynamic> json) =>
      FavouriteProfile(
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
    required this.fullName,
    required this.profileImage,
    required this.age,
    required this.city,
    required this.interested,
  });

  String fullName;
  String profileImage;
  String age;
  String city;
  String interested;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        fullName: json["full_name"],
        profileImage: json["profile_image"],
        age: json["age"],
        city: json["city"],
        interested: json["interested"],
      );

  Map<String, dynamic> toJson() => {
        "full_name": fullName,
        "profile_image": profileImage,
        "age": age,
        "city": city,
        "interested": interested,
      };
}

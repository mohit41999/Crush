import 'dart:convert';

import 'package:crush/Model/favourite_profile.dart';
import 'package:crush/util/App_constants/appconstants.dart';
import 'package:http/http.dart' as http;

class favouriteProfileService {
  Future<FavouriteProfile> getfavouriteProfile(String fav_id) async {
    var Response = await http.post(
        Uri.parse(BASE_URL + AppConstants.FAVOURITES_PROFILE),
        body: {'token': '123456789', 'fav_user_id': fav_id});
    return FavouriteProfile.fromJson(jsonDecode(Response.body));
  }
}

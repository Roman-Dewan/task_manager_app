import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model.dart';

class AuthController {
  static final String _tokenKey = 'token';
  static final String _userKey = 'user';

  static UserModel? user;
  static String? accessToken;

  static Future<void> saveUserData(String token, UserModel userModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_tokenKey, token);
    await sharedPreferences.setString(_userKey, jsonEncode(userModel.toJson()));
  }

  static Future<void> getUserData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    if (token != null) {
      accessToken = token;
      user = UserModel.fromJson(jsonDecode(
        sharedPreferences.getString(_userKey)!
      ));
    }
  }
}

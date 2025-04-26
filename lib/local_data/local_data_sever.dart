import 'dart:convert';
import 'dart:developer';
import 'package:kolkata_fatafat/modules/profile/model/user_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSaver {
  Future clearAllData() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    log("All local data cleared successfully.");
    await sharedPreference.clear();
  }

  Future setAuthToken(String authToken) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString('authToken', authToken);
  }

  Future<String> getAuthToken() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString('authToken') ?? '';
  }

  Future setUserData(User userData) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String userJson = jsonEncode(userData.toJson());
    sharedPreference.setString('userData', userJson);
  }

  Future<User> getUserData() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    String userJson = sharedPreference.getString('userData') ?? '';

    log('userJsonuserJson ::$userJson');
    return User.fromJson(jsonDecode(userJson));
  }

  Future setPhoneNumber(String phoneNumber) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    sharedPreference.setString('phoneNumber', phoneNumber);
  }

  Future<String> getPhoneNumber() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    return sharedPreference.getString('phoneNumber') ?? '';
  }

  Future setWpNumber(String wpNumber) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    sharedPreference.setString('wpNumber', wpNumber);
  }

  Future<String> getWpNumber() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();

    return sharedPreference.getString('wpNumber') ?? '';
  }
}

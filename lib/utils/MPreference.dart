
import 'dart:convert';

import 'package:customer_flutter/db/database.dart';
import 'package:customer_flutter/models/UserProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MPreference extends ChangeNotifier{

 Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
 SharedPreferences prefs;
 static const USER_PROFILE="user_profile";

/* Future<String> putString(String key,String value) async{
   if (prefs==null)
     prefs= await _prefs;
   prefs?.setInt(key, 1).then((bool success) {
     return value;
   });
   return "";
 }*/

  void putString(String key,String value) async{
    SharedPreferences prefs =await getInstance();
    prefs?.setString(key, value);
  }

  Future<SharedPreferences> getInstance() async{
    if (prefs==null)
      prefs= await _prefs;
    return prefs;
  }

  void putBool(String key,bool value) async{
    SharedPreferences prefs =await getInstance();
    prefs?.setBool(key, value);
  }

  Future<void> putInt(String key,int value) async{
    SharedPreferences prefs = await getInstance();
    prefs?.setInt(key, value);
  }

  Future<String> getString(String key) async{
    SharedPreferences prefs =await getInstance();
    return prefs?.getString(key) ?? "";
  }

  Future<int> getInt(String key) async{
    SharedPreferences prefs =await getInstance();
    return prefs?.getInt(key) ?? -1;
  }

  Future<UserProfile> getUserProfile() async {
    String profile=await getString(USER_PROFILE);
    if (profile.isEmpty) {
      return null;
    }
    Map<String, dynamic> data = json.decode(profile);
    return UserProfile.fromJson(data);
  }

  void saveProfile(UserProfile userProfile) async{
    String profile=json.encode(userProfile);
    putString(USER_PROFILE, profile);
  }

}
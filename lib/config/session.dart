import 'dart:convert';

import '../data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../presentation/controller/c_address.dart';
import '../presentation/controller/c_user.dart';

class Session {
  static Future<bool> saveUser(User user) async {
    final pref = await SharedPreferences.getInstance();
    Map<String, dynamic> mapUser = user.toJson();
    String stringUser = jsonEncode(mapUser);
    bool success = await pref.setString('user', stringUser);
    if (success) {
      final cUser = Get.put(CUser());
      cUser.setData(user);
    }
    return success;
  }

  static Future<User> getUser() async {
    User user = User(); // default value
    final pref = await SharedPreferences.getInstance();
    String? stringUser = pref.getString('user');
    if (stringUser != null) {
      Map<String, dynamic> mapUser = jsonDecode(stringUser);
      user = User.fromJson(mapUser);
    }
    final cUser = Get.put(CUser());
    cUser.setData(user);
    return user;
  }

  static Future<bool> clearUser() async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.remove('user');
    final cUser = Get.put(CUser());
    cUser.setData(User());
    return success;
  }

  static Future<bool> saveAddress(String address) async {
    final pref = await SharedPreferences.getInstance();
    bool success = await pref.setString('address', address);
    if (success) {
      final cAddress = Get.put(CAddress());
      cAddress.setData(address);
    }
    return success;
  }

  static Future<void> getAddress() async {
    final pref = await SharedPreferences.getInstance();
    String? address = pref.getString('address');
    final cAddress = Get.put(CAddress());
    cAddress.setData(address ?? '');
  }
}

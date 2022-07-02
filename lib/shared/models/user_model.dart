import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserModel extends ChangeNotifier {
  final String name;
  final String email;
  final String accessToken;

  UserModel({
    required this.accessToken,
    required this.name,
    required this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      accessToken: map['token'],
    );
  }

  factory UserModel.fromJson(String json) => UserModel.fromMap(
        jsonDecode(json),
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "accessToken": accessToken,
      };

  String toJson() => jsonEncode(toMap());

  static Future<String> getAccessToken() async {
    final instance = await SharedPreferences.getInstance();
    return instance.getString("accessToken") ?? "";
  }

  void clear() async {
    final instance = await SharedPreferences.getInstance();
    instance.clear();
    notifyListeners();
  }
}

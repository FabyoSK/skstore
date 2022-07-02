import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserModel {
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
}

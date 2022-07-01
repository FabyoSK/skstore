import 'dart:convert';

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
}

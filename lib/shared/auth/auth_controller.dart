import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/shared/api/api_endpoint.dart';
import 'package:store/shared/models/user_model.dart';
import 'package:http/http.dart' as http;

class AuthController {
  UserModel? _user;

  UserModel get user => _user!;

  Future<void> login(String email, String password) async {
    final url =
        Uri.parse(ApiEndpoint.resolve_endpoint(ApiEndpoint.create_user));

    final body = {
      "email": email,
      "password": password,
    };

    final response = await http.post(
      url,
      body: body,
    );

    if (response.statusCode == 201) {
      _user = UserModel.fromJson(response.body.toString());
      final instance = await SharedPreferences.getInstance();
      await instance.setString("accessToken", _user!.accessToken);
    } else {
      final errorResponse = jsonDecode(response.body.toString());
      return Future.error(errorResponse["error"]);
    }
  }

  Future<void> register(String name, String email, String password) async {}
}

import 'package:shared_preferences/shared_preferences.dart';

import 'intefaces/auth_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class AuthImpl implements AuthModel {
  var login_path = Uri.parse('http://localhost:8080/auth/login');
  Map<String, String?>? tokens;
  static AuthImpl? obj;

  @override
  Future<bool> isLogged() async {
    tokens ??= await getTokens();
    return tokens?["refresh_token"] != null && tokens?["access_token"] != null;
  }

  @override
  Future<String> login(String email, String password) async {
    Map request = {"email": email, "password": password};
    var requestBody = json.encode(request);
    var response = await http.post(login_path,
        headers: {"Content-Type": "application/json"}, body: requestBody);
    Map bodyMap = json.decode(response.body);

    if (response.statusCode != 200) {
      return bodyMap["message"];
    }

    setTokens(bodyMap["refresh_token"], bodyMap["access_token"]);
    return "";
  }

  @override
  Future<String> logout() {
    throw UnimplementedError();
  }

  Future<void> setTokens(String refreshToken, String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('refresh_token', refreshToken);
    prefs.setString('access_token', accessToken);
  }

  Future<Map<String, String?>> getTokens() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, String?> res = {
      "refresh_token": prefs.getString('refresh_token'),
      "access_token": prefs.getString('access_token')
    };
    return res;
  }

  static getInstance() {
    obj ??= AuthImpl();
    return obj;
  }
}

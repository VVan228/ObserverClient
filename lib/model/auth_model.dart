import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../entities/user/role.dart';
import '../entities/user/user.dart';

class AuthModel {
  var login_path = Uri.parse('http://localhost:8080/auth/login');
  var update_token_path =
      Uri.parse('http://localhost:8080/auth/updateAccessToken');
  Map<String, String?>? tokens;
  static AuthModel? obj;
  //Role userRole = Role.STUDENT;

  Future<Role?> isLogged() async {
    tokens ??= await getTokens();
    String refreshToken = tokens?["refresh_token"] ?? "";
    String accessToken = tokens?["access_token"] ?? "";

    //if (accessToken.isNotEmpty) {
    //  String stringUserRole = JwtDecoder.decode(accessToken)["role"];
    //  userRole = User.getRoleByString(stringUserRole);
    //}

    bool isLogged = refreshToken.isNotEmpty &&
        accessToken.isNotEmpty &&
        !JwtDecoder.isExpired(refreshToken);

    if (isLogged) {
      print("logged " + JwtDecoder.decode(refreshToken)["role"]);
      return User.getRoleByString(JwtDecoder.decode(refreshToken)["role"]);
    }
  }

  Future<String> login(String email, String password) async {
    Map request = {"email": email, "password": password};
    var requestBody = json.encode(request);
    var response = await http.post(login_path,
        headers: {"Content-Type": "application/json"}, body: requestBody);
    Map bodyMap = json.decode(response.body);

    if (response.statusCode != 200) {
      return bodyMap["message"];
    }

    await setTokens(bodyMap["refresh_token"], bodyMap["access_token"]);
    return "";
  }

  Future<void> logout(context) async {
    tokens = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> setTokens(String refreshToken, String accessToken) async {
    //String stringUserRole = JwtDecoder.decode(accessToken)["role"];
    //userRole = User.getRoleByString(stringUserRole);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('refresh_token', refreshToken);
    prefs.setString('access_token', accessToken);
    tokens ??= {};
    tokens?["refresh_token"] = prefs.getString('refresh_token');
    tokens?["access_token"] = prefs.getString('access_token');
  }

  Future<Map<String, String?>> getTokens() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, String?> res = {
      "refresh_token": prefs.getString('refresh_token'),
      "access_token": prefs.getString('access_token')
    };
    tokens = res;
    return res;
  }

  static getInstance() {
    obj ??= AuthModel();
    return obj;
  }

  //Role getCurrentUserRole() {
  //  return userRole;
  //}

  Future<String?> getAccessToken() async {
    tokens ??= await getTokens();
    String refreshToken = tokens?["refresh_token"] ?? "";
    String accessToken = tokens?["access_token"] ?? "";
    if (!JwtDecoder.isExpired(accessToken)) {
      return accessToken;
    } else if (!JwtDecoder.isExpired(refreshToken)) {
      Map request = {"refresh_token": refreshToken};
      var requestBody = json.encode(request);

      var response = await http.post(update_token_path,
          headers: {"Content-Type": "application/json"}, body: requestBody);

      if (response.statusCode != 200) {
        tokens = null;
        return null;
      }

      Map bodyMap = json.decode(response.body);

      if (response.statusCode != 200) {
        return null;
      }
      setTokens(bodyMap["refresh_token"], bodyMap["access_token"]);
      return bodyMap["access_token"];
    }
  }
}

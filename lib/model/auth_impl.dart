import 'intefaces/auth_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class AuthImpl implements AuthModel {
  var login_path = Uri.parse('http://localhost:8080/auth/login');

  @override
  String? getEmail() {
    throw UnimplementedError();
  }

  @override
  bool isLogged() {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> signIn(String email, String password) async {
    Map request = {"email": email, "password": password};
    var body = json.encode(request);
    Future<http.Response> response = http.post(login_path,
        headers: {"Content-Type": "application/json"}, body: body);
    return response;
  }

  @override
  Future<String> signOut() {
    throw UnimplementedError();
  }
}

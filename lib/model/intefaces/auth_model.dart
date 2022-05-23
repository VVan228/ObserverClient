import 'package:http/http.dart' as http;

abstract class AuthModel {
  //Future<String> signIn(String email, String password) async {
  Future<http.Response> signIn(String email, String password) async {
    throw UnimplementedError();
  }

  Future<String> signOut() async {
    return "";
  }

  bool isLogged() {
    return false;
  }

  String? getEmail() {
    throw UnimplementedError();
  }
}

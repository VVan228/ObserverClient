import 'package:http/http.dart' as http;

abstract class AuthModel {
  //Future<String> signIn(String email, String password) async {
  Future<String> login(String email, String password) async {
    throw UnimplementedError();
  }

  Future<String> logout() async {
    return "";
  }

  Future<bool> isLogged() {
    throw UnimplementedError();
  }
}

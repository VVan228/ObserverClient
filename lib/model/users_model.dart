import 'dart:convert';

import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:observer_client/model/auth_model.dart';
import 'package:http/http.dart' as http;
import '../entities/user/role.dart';
import '../entities/user/user.dart';

class UserModel {
  static UserModel? obj;

  String globalPath = "http://localhost:8080";

  int studentsPage = 0;
  int teachersPage = 0;
  AuthModel authImpl = AuthModel.getInstance();

  static getInstanse() {
    obj ??= UserModel();
    return obj;
  }

  Future<List<User>> getUsersPage(Role role) async {
    String stringPath = globalPath + "/users/get";
    if (role == Role.STUDENT) {
      stringPath = stringPath + "/students?page=" + studentsPage.toString();
    } else if (role == Role.TEACHER) {
      stringPath = stringPath + "/teachers?page=" + teachersPage.toString();
    } else {
      return List.empty();
    }
    var path = Uri.parse(stringPath);

    String accessToken = await authImpl.getAccessToken() ?? "";

    if (accessToken.isEmpty) {
      return List.empty();
    }

    var response =
        await http.get(path, headers: {"Authorization": accessToken});

    Map<String, dynamic> bodyMap = json.decode(response.body);
    List<dynamic> usersList = bodyMap['content'];
    List<User> usersListMapped = usersList.map((e) => User.fromMap(e)).toList();

    //print(user);
    //print(JwtDecoder.getExpirationDate(accessToken));
    return usersListMapped;
  }

  Future<String?> saveUser(User user) async {
    String stringPath = globalPath + "/users/save";
    if (user.role == Role.STUDENT) {
      stringPath = stringPath + "/student";
    } else if (user.role == Role.TEACHER) {
      stringPath = stringPath + "/teachers";
    } else {
      return null;
    }
    var path = Uri.parse(stringPath);

    String accessToken = await authImpl.getAccessToken() ?? "";

    if (accessToken.isEmpty) {
      return null;
    }
    var response = await http.post(path,
        headers: {
          "Authorization": accessToken,
          "Content-Type": "application/json"
        },
        body: user.toJson());

    if (response.statusCode == 200) {
      return "";
    }
    return null;
  }

  Future<List<User>> getStudentsPage() async {
    return getUsersPage(Role.STUDENT);
  }

  Future<List<User>> getTeachersPage() async {
    return getUsersPage(Role.TEACHER);
  }

  void nextStudentPage() {
    studentsPage++;
  }

  void nextTeacherPage() {
    teachersPage++;
  }
}

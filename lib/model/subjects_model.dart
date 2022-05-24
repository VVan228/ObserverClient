import 'dart:convert';

import 'package:observer_client/entities/global/subject.dart';
import 'package:observer_client/entities/global/subject_plain.dart';
import 'package:http/http.dart' as http;
import 'package:observer_client/model/auth_model.dart';

class SubjectsModel {
  static SubjectsModel? obj;
  int page = 0;
  AuthModel authImpl = AuthModel.getInstance();
  String globalPath = "http://localhost:8080";

  static getInstanse() {
    obj ??= SubjectsModel();
    return obj;
  }

  Future<List<SubjectPlain>?> getSubjectsPage() async {
    String stringPath = globalPath + "/subjects/get/all";

    var path = Uri.parse(stringPath);

    String accessToken = await authImpl.getAccessToken() ?? "";

    if (accessToken.isEmpty) {
      return null;
    }

    var response =
        await http.get(path, headers: {"Authorization": accessToken});

    if (response.statusCode != 200) {
      return null;
    }

    List<dynamic> subjectsList = json.decode(response.body);
    List<SubjectPlain> subjectsListMapped =
        subjectsList.map((e) => SubjectPlain.fromMap(e)).toList();

    //print(user);
    //print(JwtDecoder.getExpirationDate(accessToken));
    return subjectsListMapped;
  }

  Future<Subject?> getSubject(int id) async {
    String stringPath = globalPath + "/subjects/get/" + id.toString();

    var path = Uri.parse(stringPath);

    String accessToken = await authImpl.getAccessToken() ?? "";

    if (accessToken.isEmpty) {
      return null;
    }

    var response =
        await http.get(path, headers: {"Authorization": accessToken});

    if (response.statusCode != 200) {
      return null;
    }

    Map<String, dynamic> subject = json.decode(response.body);
    //print(user);
    //print(JwtDecoder.getExpirationDate(accessToken));
    return Subject.fromMap(subject);
  }

  Future<String?> addTeacherToSubject(int subjectId, int teacherId) async {
    String stringPath = globalPath +
        "/subjects/update/addTeacher/" +
        subjectId.toString() +
        "/" +
        teacherId.toString();
    var path = Uri.parse(stringPath);

    String accessToken = await authImpl.getAccessToken() ?? "";

    if (accessToken.isEmpty) {
      return null;
    }

    var response =
        await http.post(path, headers: {"Authorization": accessToken});
    if (response.statusCode == 200) {
      return "";
    }
    return response.body;
  }

  Future<String?> saveSubject(Subject subject) async {
    String stringPath = globalPath + "/subjects/save";

    var path = Uri.parse(stringPath);

    String accessToken = await authImpl.getAccessToken() ?? "";

    if (accessToken.isEmpty) {
      return null;
    }
    print(subject.toJson());
    var response = await http.post(path,
        headers: {
          "Authorization": accessToken,
          "Content-Type": "application/json"
        },
        body: subject.toJson());

    if (response.statusCode == 200) {
      return "";
    }
    return response.body;
  }

  Future<String?> updateSubjectName(int subjectId, String name) async {
    String stringPath = globalPath +
        "/subjects/update/name/" +
        subjectId.toString() +
        "/" +
        name;
    var path = Uri.parse(stringPath);

    String accessToken = await authImpl.getAccessToken() ?? "";

    if (accessToken.isEmpty) {
      return null;
    }

    var response =
        await http.post(path, headers: {"Authorization": accessToken});
    if (response.statusCode == 200) {
      return "";
    }
    return response.body;
  }
}

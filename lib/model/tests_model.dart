import 'dart:convert';

import 'package:observer_client/model/auth_model.dart';
import 'package:http/http.dart' as http;

import '../entities/test/test.dart';

class TestsModel {
  static TestsModel? obj;
  int page = 0;
  AuthModel authImpl = AuthModel.getInstance();
  String globalPath = "http://localhost:8080";

  static getInstanse() {
    obj ??= TestsModel();
    return obj;
  }

  Future<List<Test>?> getTests() async {
    String stringPath = globalPath + "/tests/get/byUser";

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

    Map<String, dynamic> bodyMap = json.decode(response.body);
    //print(bodyMap['content']);
    List<dynamic> testsList = bodyMap['content'];
    List<Test> testsListMapped = testsList.map((e) => Test.fromMap(e)).toList();
    return testsListMapped;
  }

  Future<Test?> getTest(int id) async {
    String stringPath = globalPath + "/tests/get/" + id.toString();

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

    return Test.fromJson(response.body);
  }

  Future<String?> saveTest(Test test, List<int> access) async {
    String stringPath = globalPath + "/tests/save";
    var path = Uri.parse(stringPath);

    String accessToken = await authImpl.getAccessToken() ?? "";

    if (accessToken.isEmpty) {
      return null;
    }

    var requestBody = json.encode({"test": test.toMap(), "access": access});
    //print(requestBody);
    var response = await http.post(path,
        headers: {
          "Authorization": accessToken,
          "Content-Type": "application/json"
        },
        body: requestBody);

    if (response.statusCode == 200) {
      return "";
    }
    return response.body;
  }

  Future<List<Test>?> getTestsToCheck() async {
    String stringPath = globalPath + "/tests/get/byUser/toCheck";

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

    Map<String, dynamic> bodyMap = json.decode(response.body);
    //print(bodyMap['content']);
    List<dynamic> testsList = bodyMap['content'];
    List<Test> testsListMapped = testsList.map((e) => Test.fromMap(e)).toList();
    return testsListMapped;
  }

  Future<List<Test>?> getNotAnsweredTests() async {
    String stringPath = globalPath + "/tests/get/byUser/notAnswered";

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
    //print(response.body);
    Map<String, dynamic> bodyMap = json.decode(response.body);

    List<dynamic> testsList = bodyMap["content"];
    List<Test> testsListMapped = testsList.map((e) => Test.fromMap(e)).toList();
    return testsListMapped;
  }
}

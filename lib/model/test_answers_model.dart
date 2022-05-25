import 'dart:collection';
import 'dart:convert';

import 'package:observer_client/entities/testAnswer/scored_answer.dart';
import 'package:observer_client/entities/testAnswer/test_answer.dart';
import 'package:http/http.dart' as http;
import 'package:observer_client/model/auth_model.dart';

import '../entities/test/answer.dart';

class TestAnswersModel {
  String globalPath = "http://localhost:8080";
  static TestAnswersModel? obj;
  int page = 0;
  AuthModel authImpl = AuthModel.getInstance();

  static getInstanse() {
    obj ??= TestAnswersModel();
    return obj;
  }

  Future<List<TestAnswer>?> getTestAnswersForTest(
      int id, bool validated) async {
    String stringPath = globalPath +
        "/testAnswers/get/byTest/" +
        id.toString() +
        "?validated=" +
        validated.toString();

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
    List<dynamic> testAnswersList = bodyMap['content'];
    List<TestAnswer> testAnswersListMapped =
        testAnswersList.map((e) => TestAnswer.fromMap(e)).toList();
    return testAnswersListMapped;
  }

  Future<List<TestAnswer>?> getTestAnswersForUser(bool validated) async {
    String stringPath = globalPath +
        "/testAnswers/get/byStudent?validated=" +
        validated.toString();
    print(stringPath);
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
    List<dynamic> testAnswersList = bodyMap['content'];
    List<TestAnswer> testAnswersListMapped =
        testAnswersList.map((e) => TestAnswer.fromMap(e)).toList();
    return testAnswersListMapped;
  }

  Future<TestAnswer?> getTestAnswer(int id) async {
    String stringPath = globalPath + "/testAnswers/get/" + id.toString();

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

    return TestAnswer.fromJson(response.body);
  }

  Future<String?> saveTestAnswer(Map<int, Answer> answers, int testId) async {
    String stringPath = globalPath + "/testAnswers/save";
    var path = Uri.parse(stringPath);

    String accessToken = await authImpl.getAccessToken() ?? "";

    if (accessToken.isEmpty) {
      return null;
    }

    Map<String, dynamic> resMap = {};
    answers.forEach((key, value) {
      resMap[key.toString()] = value.toMap();
    });

    var requestBody = json.encode({"answers": resMap, "testId": testId});

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

  Future<String?> setCheckAnswer(List<ScoredAnswer> answers, int testId) async {
    String stringPath =
        globalPath + "/testAnswers/set/checkAnswer/" + testId.toString();
    var path = Uri.parse(stringPath);

    String accessToken = await authImpl.getAccessToken() ?? "";

    if (accessToken.isEmpty) {
      return null;
    }

    var requestBody = json.encode(answers.map((x) => x.toMap()).toList());
    print(requestBody);

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
}

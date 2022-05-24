import 'dart:convert';

import 'package:observer_client/entities/global/H.dart';
import 'package:observer_client/entities/global/HGroup.dart';
import 'package:observer_client/entities/global/group.dart';
import 'package:observer_client/model/auth_model.dart';
import 'package:http/http.dart' as http;

class HierarchyModel {
  String globalPath = "http://localhost:8080";

  static HierarchyModel? obj;
  int page = 0;
  AuthModel authImpl = AuthModel.getInstance();

  static getInstanse() {
    obj ??= HierarchyModel();
    return obj;
  }

  Future<List<String>?> getLabels() async {
    String stringPath = globalPath + "/hierarchy/get/labels";
    var path = Uri.parse(stringPath);

    String accessToken = await authImpl.getAccessToken() ?? "";

    if (accessToken.isEmpty) {
      return null;
    }

    var response =
        await http.get(path, headers: {"Authorization": accessToken});

    if (response.statusCode == 200) {
      List<dynamic> dynamicLabels = json.decode(response.body);
      List<String> res = List.from(dynamicLabels);
      //dynamicLabels.map((e) => res.add(e));
      return res;
    }
    return null;
  }

  Future<List<Group>?> getGroupsByLevel(int lvl) async {
    String stringPath = globalPath + "/hierarchy/get/byLevel/" + lvl.toString();
    var path = Uri.parse(stringPath);

    String accessToken = await authImpl.getAccessToken() ?? "";

    if (accessToken.isEmpty) {
      return null;
    }

    var response =
        await http.get(path, headers: {"Authorization": accessToken});

    if (response.statusCode == 200) {
      List<dynamic> dynamicGroups = json.decode(response.body);
      List<Group> res = dynamicGroups.map((e) => Group.fromMap(e)).toList();
      //dynamicLabels.map((e) => res.add(e));
      return res;
    }
    return null;
  }

  Future<String?> addStudentToGroup(int groupId, int studentId) async {
    String stringPath = globalPath +
        "/hierarchy/update/addStudent/" +
        groupId.toString() +
        "/" +
        studentId.toString();
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

  Future<String?> saveHierarchy(H root) async {
    String stringPath = globalPath + "/hierarchy/save";
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
        body: root.toJson());

    if (response.statusCode == 200) {
      return "";
    }
    return response.body;
  }
}

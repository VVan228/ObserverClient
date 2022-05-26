import 'package:observer_client/entities/global/group.dart';
import 'package:observer_client/model/hierarchy_model.dart';
import 'package:observer_client/model/tests_model.dart';
import 'package:observer_client/model/users_model.dart';
import 'package:observer_client/views/interfaces/tests_list_view.dart';

import '../entities/test/test.dart';
import '../entities/user/role.dart';
import '../entities/user/user.dart';
import '../views/interfaces/student_list_view.dart';

class TestsListImpl {
  TestsListView? _view;
  TestsModel testsModel = TestsModel.getInstanse();
  HierarchyModel hierarchyModel = HierarchyModel.getInstanse();

  Future<void> setView(TestsListView view) async {
    _view = view;
  }

  void initialized() async {
    loadTests();
  }

  void update() async {
    loadTests();
  }

  void loadTests() async {
    _view?.removeAllTests();
    List<Test>? tests = await testsModel.getNotAnsweredTests();
    if (tests == null) {
      return;
    }
    tests.forEach((element) {
      _view?.addTest(element);
    });
  }
}

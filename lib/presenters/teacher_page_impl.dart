import 'package:observer_client/entities/global/group.dart';
import 'package:observer_client/model/hierarchy_model.dart';
import 'package:observer_client/model/tests_model.dart';
import 'package:observer_client/model/users_model.dart';

import '../entities/test/test.dart';
import '../entities/user/role.dart';
import '../entities/user/user.dart';
import '../views/interfaces/student_list_view.dart';
import '../views/interfaces/teacher_view.dart';

class TeacherPageImpl {
  TeacherView? _view;
  UserModel userModel = UserModel.getInstanse();
  TestsModel testsModel = TestsModel.getInstanse();
  HierarchyModel hierarchyModel = HierarchyModel.getInstanse();

  Future<void> setView(TeacherView view) async {
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
    List<Test>? tests = [];
    if (_view?.getAutoCheck() ?? false) {
      tests = await testsModel.getTests();
    } else {
      tests = await testsModel.getTestsToCheck();
    }
    if (tests == null) {
      return;
    }
    tests.forEach((element) {
      _view?.addTest(element);
    });
  }
}

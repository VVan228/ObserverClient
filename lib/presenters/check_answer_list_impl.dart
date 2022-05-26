import 'package:observer_client/entities/global/group.dart';
import 'package:observer_client/entities/testAnswer/test_answer.dart';
import 'package:observer_client/model/hierarchy_model.dart';
import 'package:observer_client/model/test_answers_model.dart';
import 'package:observer_client/model/tests_model.dart';
import 'package:observer_client/model/users_model.dart';

import '../entities/test/test.dart';
import '../entities/user/role.dart';
import '../entities/user/user.dart';
import '../views/interfaces/check_answer_list_view.dart';
import '../views/interfaces/student_list_view.dart';
import '../views/interfaces/teacher_view.dart';

class CheckAnswerListImpl {
  CheckAnswerListView? _view;
  UserModel userModel = UserModel.getInstanse();
  TestsModel testsModel = TestsModel.getInstanse();
  TestAnswersModel testAnswersModel = TestAnswersModel.getInstanse();
  HierarchyModel hierarchyModel = HierarchyModel.getInstanse();

  Future<void> setView(CheckAnswerListView view) async {
    _view = view;
  }

  void initialized() async {
    loadTests();
  }

  void update() async {
    loadTests();
  }

  void loadTests() async {
    _view?.removeAllTestAnswers();
    List<TestAnswer>? tests = await testAnswersModel.getTestAnswersForTest(
        _view?.getId() ?? 0, false);
    tests!.forEach((element) {
      _view?.addTestAnswer(element);
    });
  }
}

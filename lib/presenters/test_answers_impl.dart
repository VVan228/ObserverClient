import 'package:observer_client/entities/global/group.dart';
import 'package:observer_client/entities/testAnswer/test_answer.dart';
import 'package:observer_client/model/hierarchy_model.dart';
import 'package:observer_client/model/test_answers_model.dart';
import 'package:observer_client/model/tests_model.dart';
import 'package:observer_client/model/users_model.dart';
import 'package:observer_client/views/interfaces/test_answers_view.dart';
import 'package:observer_client/views/interfaces/tests_list_view.dart';

import '../entities/test/test.dart';
import '../entities/user/role.dart';
import '../entities/user/user.dart';
import '../views/interfaces/student_list_view.dart';

class TestAnswersListImpl {
  TestAnswersListView? _view;
  TestAnswersModel testsModel = TestAnswersModel.getInstanse();
  TestsModel testsModel2 = TestsModel.getInstanse();
  HierarchyModel hierarchyModel = HierarchyModel.getInstanse();

  Future<void> setView(TestAnswersListView view) async {
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
    _view?.removeAllTests();
    List<TestAnswer>? tests =
        await testsModel.getTestAnswersForUser(_view?.getValidated() ?? true);
    if (tests == null) {
      return;
    }
    tests.forEach((element) async {
      Test? t = await testsModel2.getTest(element.testId);
      _view?.addTestAnswer(element);
      _view?.addTest(t ??
          Test(timeLimit: 0, questions: [], subjectId: 1, name: "empty name"));
    });
  }
}

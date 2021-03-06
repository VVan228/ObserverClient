import 'package:observer_client/entities/test/test.dart';
import 'package:observer_client/entities/testAnswer/test_answer.dart';

abstract class TestAnswersListView {
  void removeAllTestAnswers();
  void addTestAnswer(TestAnswer test);
  void removeAllTests();
  void addTest(Test test);
  bool getValidated();
}

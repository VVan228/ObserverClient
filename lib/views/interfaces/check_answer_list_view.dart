import 'package:observer_client/entities/testAnswer/test_answer.dart';

import '../../entities/test/test.dart';

abstract class CheckAnswerListView {
  void addTestAnswer(TestAnswer test);
  void removeAllTestAnswers();
  int getId();
}

import '../../entities/test/test.dart';

abstract class TeacherView {
  void addTest(Test test);
  void removeAllTests();
  bool getAutoCheck();
}

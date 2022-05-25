import '../../entities/user/user.dart';

abstract class AddTeacherView {
  void addUser(User user);
  void removeAllUsers();
  void setTitle(String t);
  int getSubjectId();
  Future<User?> getTeacher(List<User> teachers);
}

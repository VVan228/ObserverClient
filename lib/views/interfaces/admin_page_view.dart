import 'package:observer_client/entities/global/subject.dart';
import 'package:observer_client/entities/user/user.dart';

abstract class AdminPageView {
  Future<User?> getUserData();
  Future<Subject?> getSubjectData();
  bool isSubjectListPageOpened();
}

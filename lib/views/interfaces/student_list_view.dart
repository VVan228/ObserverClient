import '../../entities/user/role.dart';
import '../../entities/user/user.dart';

abstract class UserListView {
  void addUser(User user);
  void removeAllUsers();
  Role getRole();
}

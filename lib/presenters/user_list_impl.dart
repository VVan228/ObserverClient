import 'package:observer_client/model/users_model.dart';

import '../entities/user/role.dart';
import '../entities/user/user.dart';
import '../views/interfaces/student_list_view.dart';

class UserListImpl {
  UserListView? _view;
  UserModel userModel = UserModel.getInstanse();

  Future<void> setView(UserListView view) async {
    _view = view;
  }

  void initialized() async {
    loadUsers();
  }

  void update() async {
    loadUsers();
  }

  void loadUsers() async {
    _view?.removeAllUsers();
    List<User> users = [];
    if (_view?.getRole() == Role.STUDENT) {
      users = await userModel.getStudentsPage();
    } else if (_view?.getRole() == Role.TEACHER) {
      users = await userModel.getTeachersPage();
    }
    users.forEach((element) {
      _view?.addUser(element);
    });
  }
}

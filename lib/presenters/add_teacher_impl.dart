import 'dart:math';

import 'package:observer_client/model/subjects_model.dart';
import 'package:observer_client/model/users_model.dart';
import 'package:observer_client/views/interfaces/add_teacher_view.dart';

import '../entities/global/subject.dart';
import '../entities/user/user.dart';
import '../model/auth_model.dart';

class AddTeacherImpl {
  final AuthModel _authModel = AuthModel.getInstance();
  final UserModel userModel = UserModel.getInstanse();
  final SubjectsModel subjectsModel = SubjectsModel.getInstanse();
  AddTeacherView? _view;

  Future<void> setView(AddTeacherView view) async {
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
    Subject? subj = await subjectsModel.getSubject(_view?.getSubjectId() ?? 0);
    _view?.setTitle(subj?.name ?? '');
    subj?.teachers?.forEach((element) {
      _view?.addUser(element);
    });
  }

  void addClicked() async {
    User? teacher = await _view?.getTeacher(await userModel.getTeachersPage());
    if (teacher != null) {
      print("tried");
      print(await subjectsModel.addTeacherToSubject(
          _view?.getSubjectId() ?? 0, teacher.id ?? 0));
    }
  }
}

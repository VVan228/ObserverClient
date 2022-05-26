import 'dart:convert';

import 'package:observer_client/entities/user/role.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/auth_model.dart';
import '../views/interfaces/sign_in_view.dart';

class SignInImpl {
  final AuthModel _authModel = AuthModel.getInstance();
  SignInView? _view;

  void submitClick(String email, String password) async {
    var res = await _authModel.login(email, password);
    if (!res.isEmpty) {
      _view?.showMassage(res);
    } else {
      Role? role = await _authModel.isLogged();
      print("login role " + (role?.name ?? 'nope'));
      switch (role) {
        case Role.ADMIN:
          {
            _view?.openAdminPage();
            break;
          }
        case Role.STUDENT:
          _view?.openStudentPage();
          break;
        case Role.TEACHER:
          _view?.openTeacherPage();
          break;
        case null:
          {
            break;
          }
      }
    }
  }

  Future<void> setView(SignInView view) async {
    _view = view;
  }
}

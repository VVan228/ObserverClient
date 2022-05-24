import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/auth_model.dart';
import '../views/interfaces/sign_in_view.dart';
import 'interfaces/sign_in_presenter.dart';

class SignInImpl implements SignInPresenter {
  final AuthModel _authModel = AuthModel.getInstance();
  SignInView? _view;

  @override
  void submitClick(String email, String password) async {
    var res = await _authModel.login(email, password);
    if (!res.isEmpty) {
      _view?.showMassage(res);
    } else {
      _view?.showMassage("");
    }
  }

  @override
  Future<void> setView(SignInView view) async {
    _view = view;
  }
}

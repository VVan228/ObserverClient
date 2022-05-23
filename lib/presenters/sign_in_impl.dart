import 'dart:convert';

import '../model/auth_impl.dart';
import '../model/intefaces/auth_model.dart';
import '../views/interfaces/sign_in_view.dart';
import 'interfaces/sign_in_presenter.dart';

class SignInImpl implements SignInPresenter {
  final AuthModel _authModel = AuthImpl();
  SignInView? _view;

  @override
  void submitClick(String email, String password) async {
    var res = await _authModel.signIn(email, password);
    if (res.statusCode == 200) {
    } else {
      // _view?.showMassage();
    }
  }

  @override
  void setView(SignInView view) {
    _view = view;
  }
}

import '../model/auth_impl.dart';
import '../model/intefaces/auth_model.dart';
import '../views/interfaces/sign_in_view.dart';
import 'interfaces/sign_in_presenter.dart';

class SignInImpl implements SignInPresenter {
  final AuthModel _authModel = AuthImpl();
  SignInView? _view;

  @override
  void submitClick(String email, String password) async {
    var res = await _authModel.login(email, password);
    if (res.isNotEmpty) {
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

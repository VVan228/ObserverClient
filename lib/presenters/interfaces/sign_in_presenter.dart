import '../../views/interfaces/sign_in_view.dart';

abstract class SignInPresenter {
  void submitClick(String email, String password) {}
  void setView(SignInView view) {}
}

import '../entities/user/user.dart';
import '../model/users_model.dart';
import '../views/interfaces/admin_page_view.dart';

class AdminPageImpl {
  AdminPageView? _view;
  UserModel userModel = UserModel.getInstanse();

  Future<void> setView(AdminPageView view) async {
    _view = view;
  }

  void addClicked() async {
    User? user = await _view?.getUserData();
    if (user != null) {
      userModel.saveUser(user);
    }
  }
}

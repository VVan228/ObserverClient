import 'package:observer_client/entities/global/subject.dart';
import 'package:observer_client/model/subjects_model.dart';

import '../entities/user/user.dart';
import '../model/users_model.dart';
import '../views/interfaces/admin_page_view.dart';

class AdminPageImpl {
  AdminPageView? _view;
  UserModel userModel = UserModel.getInstanse();
  SubjectsModel subjectsModel = SubjectsModel.getInstanse();

  Future<void> setView(AdminPageView view) async {
    _view = view;
  }

  void addClicked() async {
    if (_view?.isSubjectListPageOpened() ?? false) {
      Subject? subj = await _view?.getSubjectData();
      if (subj != null) {
        subjectsModel.saveSubject(subj);
      }
    }
    User? user = await _view?.getUserData();
    if (user != null) {
      userModel.saveUser(user);
    }
  }
}

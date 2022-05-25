import 'package:observer_client/entities/global/subject_plain.dart';
import 'package:observer_client/model/subjects_model.dart';
import 'package:observer_client/model/users_model.dart';
import 'package:observer_client/views/interfaces/subject_list_view.dart';

import '../entities/user/role.dart';
import '../entities/user/user.dart';

class SubjectListImpl {
  SubjectListView? _view;
  SubjectsModel subjectsModel = SubjectsModel.getInstanse();

  Future<void> setView(SubjectListView view) async {
    _view = view;
  }

  void initialized() async {
    loadSubjects();
  }

  void update() async {
    loadSubjects();
  }

  void loadSubjects() async {
    _view?.removeAllSubjects();
    List<SubjectPlain>? subjects = await subjectsModel.getSubjectsPage();
    subjects?.forEach((element) {
      _view?.addSubject(element);
    });
  }
}

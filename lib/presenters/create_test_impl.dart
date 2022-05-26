import 'package:observer_client/model/tests_model.dart';
import 'package:observer_client/views/interfaces/create_test_view.dart';

import '../entities/global/group.dart';
import '../model/hierarchy_model.dart';
import '../model/users_model.dart';

class CreateTestImpl {
  CreateTestView? _view;
  TestsModel testsModel = TestsModel.getInstanse();
  HierarchyModel hierarchyModel = HierarchyModel.getInstanse();

  Future<void> setView(CreateTestView view) async {
    _view = view;
  }

  void initialized() async {
    List<String>? labels = await hierarchyModel.getLabels();
    List<Group>? groups =
        await hierarchyModel.getGroupsByLevel((labels?.length ?? 1) - 1);
    _view?.setGroups(groups ?? []);
  }

  void submitClick() {}
}

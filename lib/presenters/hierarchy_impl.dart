import 'package:observer_client/model/hierarchy_model.dart';
import 'package:observer_client/views/interfaces/hierarchy_view.dart';

class HierarchyImpl {
  HierarchyView? _view;
  HierarchyModel hierarchyModel = HierarchyModel.getInstanse();

  Future<void> setView(HierarchyView view) async {
    _view = view;
  }

  void addClicked() {
    _view?.getNewNode();
  }
}

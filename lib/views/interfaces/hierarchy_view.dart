abstract class HierarchyView {
  Future<Map<String, dynamic>?> getNewNode();
  Map<String, dynamic> getTree();
  List<String> getTreeLegend();
  void back();
}

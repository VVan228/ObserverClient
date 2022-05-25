import 'dart:math';

import 'package:flutter/material.dart';
import 'package:graphview/GraphView.dart';
import 'package:observer_client/entities/global/H.dart';
import 'package:observer_client/entities/global/HGroup.dart';
import 'package:observer_client/presenters/hierarchy_impl.dart';
import 'package:observer_client/views/interfaces/hierarchy_view.dart';

import 'add_node_page.dart';

class HierarchyPage extends StatefulWidget {
  const HierarchyPage({Key? key}) : super(key: key);

  //Role role = Role.STUDENT;
  @override
  State<HierarchyPage> createState() => _StudentListState();
}

class _StudentListState extends State<HierarchyPage> implements HierarchyView {
  HierarchyImpl presenter = HierarchyImpl();

  H tree = H();
  List<H> listTree = [];
  Map<int, String> names = {};
  int nextId = 1;
  int maxLvl = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            presenter.addClicked();
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: InteractiveViewer(
                  constrained: false,
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.01,
                  maxScale: 5.6,
                  child: GraphView(
                    graph: graph,
                    algorithm: BuchheimWalkerAlgorithm(
                        builder, TreeEdgeRenderer(builder)),
                    paint: Paint()
                      ..color = Colors.black
                      ..strokeWidth = 2
                      ..style = PaintingStyle.stroke,
                    builder: (Node node) {
                      // I can decide what widget should be shown here based on the id
                      var a = node.key?.value as int;
                      return rectangleWidget(a);
                    },
                  )),
            ),
          ],
        ));
  }

  Random r = Random();

  Widget rectangleWidget(int a) {
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          boxShadow: const [
            BoxShadow(color: Colors.orange, spreadRadius: 1),
          ],
        ),
        child: Text('Node $a'));
  }

  final Graph graph = Graph()..isTree = true;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();

  @override
  void initState() {
    presenter.setView(this);

    final root = Node.Id(0);
    graph.addNode(root);
    tree.id = 0;
    listTree.add(tree);
    names[0] = "root";

    builder
      ..siblingSeparation = (100)
      ..levelSeparation = (150)
      ..subtreeSeparation = (150)
      ..orientation = (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
  }

  List<int> lvls = [];
  int chosenLvl = 1;
  int? chosenParent = 1;
  List<int> parents = [];

  @override
  Future<Map<String, dynamic>?> getNewNode() async {
    Map<String, dynamic>? res;
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddNodePage(
                  tree: tree,
                  names: names,
                  maxLvl: maxLvl,
                ))).then((value) {
      if (value != null) {
        res = value;
      }
    });

    setState(() {
      names[nextId] = res?["name"].toString() ?? '';
      int chosenLvl = res?["lvl"] ?? 0;
      int chosenParent = res?["parent"] ?? 0;

      final node1 = Node.Id(chosenParent);
      final node2 = Node.Id(nextId);
      graph.addEdge(node1, node2);

      H newNode = H()..id = nextId;

      listTree.add(newNode);

      for (H h in listTree) {
        if (h.id == chosenParent) {
          h.children ??= [];
          h.children?.add(newNode);
        }
      }
      print("tree:" + tree.toJson());
      print("names:" + names.toString());

      nextId++;
      if (chosenLvl >= maxLvl) {
        maxLvl++;
      }
    });

    return res;
  }
}

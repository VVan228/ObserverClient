import 'package:flutter/material.dart';

import '../entities/global/H.dart';

class AddNodePage extends StatefulWidget {
  H tree;
  Map<int, String> names;
  int maxLvl;

  AddNodePage(
      {Key? key, required this.tree, required this.names, required this.maxLvl})
      : super(key: key);

  @override
  State<AddNodePage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<AddNodePage> {
  List<int> lvls = [];
  int chosenLvl = 1;
  int? chosenParent = 1;
  List<int> parents = [];

  List<int> getLvl(int lvl) {
    return getLvlIter(lvl, 0, [], widget.tree);
  }

  List<int> getLvlIter(int lvl, int i, List<int> res, H curr) {
    if (i == lvl) {
      res.add(curr.id ?? 0);
      return res;
    }
    print("lvl " + lvl.toString() + " i " + i.toString());
    curr.children?.forEach((element) {
      getLvlIter(lvl, i + 1, res, element);
    });
    return res;
  }

  @override
  void initState() {
    lvls = [];
    for (int i = 1; i < widget.maxLvl + 1; i++) {
      lvls.add(i);
    }

    parents = getLvl(0);
    chosenLvl = 1;
    chosenParent = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _nameController = TextEditingController();

    return Scaffold(
        body: Center(
      child: SizedBox(
        width: 500,
        height: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButton<int>(
                hint: const Text("Выберите уровень"),
                items: lvls
                    .map((e) => DropdownMenuItem<int>(
                        value: e, child: Text(e.toString())))
                    .toList(),
                value: chosenLvl,
                onChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      //aaprint(value);
                      chosenLvl = value;
                      //parents.add(1);
                      parents = getLvl(value - 1);
                      chosenParent = parents[0];
                    });
                  }
                }),
            DropdownButton<int>(
                hint: const Text("Выберите родителя"),
                value: chosenParent,
                items: parents
                    .map((e) => DropdownMenuItem<int>(
                        value: e, child: Text(widget.names[e] ?? '')))
                    .toList(),
                onChanged: (int? value) {
                  if (value != null) {
                    setState(() {
                      chosenParent = value;
                    });
                  }
                }),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'название группы'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, {
                    "parent": chosenParent,
                    "lvl": chosenLvl,
                    "name": _nameController.text
                  });
                },
                child: Text("подтвердить"))
          ],
        ),
      ),
    ));
  }
}

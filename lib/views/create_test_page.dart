import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:observer_client/entities/global/group.dart';
import 'package:observer_client/entities/test/question.dart';
import 'package:observer_client/presenters/create_test_impl.dart';
import 'package:observer_client/views/interfaces/create_test_view.dart';

import 'add_question_page.dart';

class CreateTestPage extends StatefulWidget {
  CreateTestPage({Key? key}) : super(key: key);

  CreateTestImpl presenter = CreateTestImpl();

  @override
  State<CreateTestPage> createState() => _CreateTestPageState();
}

class _CreateTestPageState extends State<CreateTestPage>
    implements CreateTestView {
  final nameController = TextEditingController();
  List<Group> groups = [];
  List<Group> selectedGroups = [];
  List<MultiSelectItem<Group>> groupsSelect = [];

  List<Question>? questions;
  int qLen = 0;

  @override
  void initState() {
    widget.presenter.setView(this);
    widget.presenter.initialized();
    super.initState();
  }

  @override
  void setGroups(List<Group> g) {
    setState(() {
      groups = g;
      groupsSelect = g.map((e) => MultiSelectItem<Group>(e, e.name)).toList();
    });
    //print(groupsSelect);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Создание теста"),
        ),
        body: Center(
          child: SizedBox(
            width: 400,
            child: Form(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Введите данные теста',
                          style: Theme.of(context).textTheme.headline4),
                      const SizedBox(
                        width: 32,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: 'название'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MultiSelectDialogField(
                      title: const Text("выберите группы"),
                      buttonText: const Text("группы с доступом"),
                      items: groupsSelect,
                      listType: MultiSelectListType.CHIP,
                      onConfirm: (values) {
                        selectedGroups = values as List<Group>;
                        print(selectedGroups);
                      },
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        child: Column(
                          children: [
                            TextButton(
                              onPressed: () async {
                                questions = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddQuestionsPage()),
                                );
                                setState(() {
                                  qLen = questions?.length ?? 0;
                                  //print(questions);
                                });
                              },
                              child: Text(
                                  "добавить вопросы (" + qLen.toString() + ")"),
                            ),
                          ],
                        ),
                        width: 350,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: TextButton(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> states) {
                          return Colors.white;
                        }),
                        backgroundColor: MaterialStateProperty.resolveWith(
                            (Set<MaterialState> states) {
                          return Theme.of(context).colorScheme.secondary;
                        }),
                      ),
                      onPressed: () {
                        widget.presenter.submitClick();
                      },
                      child: const Text('submit'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:observer_client/entities/test/test.dart';
import 'package:observer_client/entities/testAnswer/test_answer.dart';
import 'package:observer_client/entities/user/user.dart';
import 'package:observer_client/model/auth_model.dart';
import 'package:observer_client/presenters/teacher_page_impl.dart';
import 'package:observer_client/views/interfaces/teacher_view.dart';
import 'package:observer_client/views/sign_in_page.dart';

import '../entities/user/role.dart';
import '../presenters/check_answer_list_impl.dart';
import 'interfaces/check_answer_list_view.dart';

class CheckAnswerList extends StatefulWidget {
  CheckAnswerList({Key? key, required this.test}) : super(key: key);

  CheckAnswerListImpl presenter = CheckAnswerListImpl();
  AuthModel auth = AuthModel.getInstance();
  Test test;

  @override
  State<CheckAnswerList> createState() => _CheckAnswerListState();
}

class _CheckAnswerListState extends State<CheckAnswerList>
    implements CheckAnswerListView {
  @override
  void initState() {
    widget.presenter.setView(this);
    widget.presenter.initialized();
    super.initState();
  }

  List<TestAnswer> tests = [
    TestAnswer(
        id: 0,
        testId: 0,
        answers: [],
        student: User(role: Role.STUDENT, email: "", name: ""),
        totalScore: 0,
        maxScore: 0,
        dateMillis: DateTime(1))
  ];

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.red;
    }
    return Colors.orange;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Неоцененные ответы на тест " + widget.test.name),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        body: Center(
          child: ConstrainedBox(
            child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: tests.length,
                itemBuilder: (context, index) {
                  if (index == tests.length - 1) {
                    return IconButton(
                      icon: Icon(Icons.update),
                      onPressed: () {
                        widget.presenter.update();
                      },
                    );
                  }
                  String name = tests[index].student.name;
                  return GestureDetector(
                    onTap: () {
                      //Navigator.push(
                      //  context,
                      //  MaterialPageRoute(
                      //      builder: (context) => AddTeacherPage(
                      //            subjectId: subjectId,
                      //          )),
                      //);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
            constraints: const BoxConstraints(maxWidth: 500, minWidth: 200),
          ),
        ));
  }

  @override
  void addTestAnswer(TestAnswer test) {
    setState(() {
      tests.insert(0, test);
    });
  }

  @override
  void removeAllTestAnswers() {
    setState(() {
      tests = [
        TestAnswer(
            id: 0,
            testId: 0,
            answers: [],
            student: User(role: Role.STUDENT, email: "", name: ""),
            totalScore: 0,
            maxScore: 0,
            dateMillis: DateTime(1))
      ];
    });
  }

  @override
  int getId() {
    return widget.test.id ?? 0;
  }
}

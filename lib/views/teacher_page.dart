import 'package:flutter/material.dart';
import 'package:observer_client/entities/test/test.dart';
import 'package:observer_client/model/auth_model.dart';
import 'package:observer_client/presenters/teacher_page_impl.dart';
import 'package:observer_client/views/check_answer_list.dart';
import 'package:observer_client/views/create_test_page.dart';
import 'package:observer_client/views/interfaces/teacher_view.dart';
import 'package:observer_client/views/sign_in_page.dart';

class TeacherPage extends StatefulWidget {
  TeacherPage({Key? key}) : super(key: key);

  TeacherPageImpl presenter = TeacherPageImpl();
  AuthModel auth = AuthModel.getInstance();

  @override
  State<TeacherPage> createState() => _TeacherPageState();
}

class _TeacherPageState extends State<TeacherPage> implements TeacherView {
  @override
  void initState() {
    widget.presenter.setView(this);
    widget.presenter.initialized();
    super.initState();
  }

  List<Test> tests = [
    Test(timeLimit: 0, questions: [], subjectId: 0, name: "")
  ];
  bool notAutoCheck = false;

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
          title: const Text("Тесты"),
          leading: IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await widget.auth.logout(context);
              widget.auth.isLogged();
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
          ),
          actions: [
            Container(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    const Text("notAutoCheck"),
                    Checkbox(
                      checkColor: Colors.white,
                      value: notAutoCheck,
                      onChanged: (bool? value) {
                        setState(() {
                          notAutoCheck = value!;
                        });
                        widget.presenter.update();
                      },
                    ),
                  ],
                ),
              ),
              color: Colors.white,
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateTestPage()),
            );
          },
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
                  String name = tests[index].name;
                  int testId = tests[index].id ?? 1;
                  return GestureDetector(
                    onTap: () {
                      if (notAutoCheck) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckAnswerList(
                                    test: tests[index],
                                  )),
                        );
                      }
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
                        padding: EdgeInsets.all(15),
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
  void addTest(Test test) {
    setState(() {
      tests.insert(0, test);
    });
  }

  @override
  void removeAllTests() {
    setState(() {
      tests = [Test(timeLimit: 0, questions: [], subjectId: 0, name: "")];
    });
  }

  @override
  bool getAutoCheck() {
    return notAutoCheck;
  }
}

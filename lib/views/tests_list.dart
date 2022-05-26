import 'package:flutter/material.dart';
import 'package:observer_client/entities/test/test.dart';
import 'package:observer_client/presenters/tests_list_impl.dart';
import 'package:observer_client/views/create_test_answer.dart';
import 'package:observer_client/views/interfaces/tests_list_view.dart';

class TestsList extends StatefulWidget {
  TestsList({Key? key}) : super(key: key);

  TestsListImpl presenter = TestsListImpl();

  @override
  State<TestsList> createState() => _StudentListState();
}

class _StudentListState extends State<TestsList> implements TestsListView {
  List<Test> tests = [
    Test(timeLimit: 0, questions: [], subjectId: 0, name: "")
  ];

  @override
  void initState() {
    widget.presenter.setView(this);
    widget.presenter.initialized();
    super.initState();
  }

  @override
  void addTest(Test test) {
    setState(() {
      tests.insert(0, test);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateTestAnswer(
                            test: tests[index],
                          )),
                );
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
    ));
  }

  @override
  void removeAllTests() {
    setState(() {
      tests = [Test(timeLimit: 0, questions: [], subjectId: 0, name: "")];
    });
  }
}

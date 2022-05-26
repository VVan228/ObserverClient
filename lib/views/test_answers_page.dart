import 'package:flutter/material.dart';
import 'package:observer_client/entities/test/test.dart';
import 'package:observer_client/entities/testAnswer/test_answer.dart';
import 'package:observer_client/presenters/test_answers_impl.dart';
import 'package:observer_client/presenters/tests_list_impl.dart';
import 'package:observer_client/views/create_test_answer.dart';
import 'package:observer_client/views/interfaces/test_answers_view.dart';
import 'package:observer_client/views/interfaces/tests_list_view.dart';
import 'package:observer_client/views/test_answer_page.dart';

class TestAnswersList extends StatefulWidget {
  TestAnswersList({Key? key}) : super(key: key);

  TestAnswersListImpl presenter = TestAnswersListImpl();

  @override
  State<TestAnswersList> createState() => _StudentListState();
}

class _StudentListState extends State<TestAnswersList>
    implements TestAnswersListView {
  List<TestAnswer?> tests = [null];
  List<Test?> testsNames = [null];

  bool validated = true;

  @override
  void initState() {
    widget.presenter.setView(this);
    widget.presenter.initialized();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "validated",
        onPressed: () {},
        child: Checkbox(
          value: validated,
          onChanged: (bool? value) {
            validated = !validated;
            widget.presenter.update();
          },
        ),
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
              int testId = tests[index]!.testId;
              String testName = testsNames[index]!.name;
              int score = tests[index]?.totalScore ?? 0;
              int maxScore = tests[index]?.maxScore ?? 0;

              Color C = validated ? Colors.green : Colors.red;

              return GestureDetector(
                onTap: () {
                  if (!validated) {
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TestAnswerPage(
                              test: testsNames[index]!,
                              answer: tests[index]!,
                            )),
                  );
                },
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          testName,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Text(
                                  score.toString() + "/" + maxScore.toString()),
                            ),
                            Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                  color: C, shape: BoxShape.circle),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
        constraints: const BoxConstraints(maxWidth: 500, minWidth: 200),
      )),
    );
  }

  @override
  void addTestAnswer(TestAnswer test) {
    setState(() {
      tests.insert(0, test);
    });
  }

  @override
  bool getValidated() {
    return validated;
  }

  @override
  void removeAllTestAnswers() {
    setState(() {
      tests = [null];
    });
  }

  @override
  void addTest(Test test) {
    testsNames.insert(0, test);
  }

  @override
  void removeAllTests() {
    testsNames = [null];
  }
}

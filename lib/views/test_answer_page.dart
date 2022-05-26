import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:observer_client/entities/test/answer.dart';
import 'package:observer_client/entities/test/question.dart';
import 'package:observer_client/entities/test/question_type.dart';
import 'package:observer_client/entities/test/test.dart';
import 'package:observer_client/entities/test/variant.dart';
import 'package:observer_client/entities/testAnswer/scored_answer.dart';
import 'package:observer_client/model/test_answers_model.dart';

import '../entities/testAnswer/test_answer.dart';

class TestAnswerPage extends StatefulWidget {
  TestAnswerPage({Key? key, required this.test, required this.answer})
      : super(key: key);

  TestAnswersModel testAnswersModel = TestAnswersModel.getInstanse();

  Test test;
  TestAnswer answer;

  @override
  State<TestAnswerPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<TestAnswerPage> {
  Map<int, ScoredAnswer> answers = {};

  @override
  void initState() {
    for (ScoredAnswer q in widget.answer.answers) {
      answers[q.questionId] = q;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ответ " + widget.answer.student.name),
      ),
      body: Center(
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500, minWidth: 200),
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.test.questions.length,
                  itemBuilder: (context, index) {
                    String name = widget.test.questions[index].questionText;
                    //int testId = tests[index].id ?? 1;
                    return GestureDetector(
                      onTap: () {},
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Card(
                                color: Colors.white,
                                child: Padding(
                                  child: Container(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(name),
                                          Text(answers[widget
                                                      .test.questions[index].id]
                                                  ?.score
                                                  .toString() ??
                                              "")
                                        ]),
                                    width: 500,
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 18, right: 18, top: 9, bottom: 9),
                                )),
                          ),
                          Visibility(
                              visible:
                                  widget.test.questions[index].questionType ==
                                      QuestionType.OpenQuestionCheck,
                              child: Center(
                                  child: Card(
                                      child: Padding(
                                child: SizedBox(
                                  child: Text(
                                    answers[widget.test.questions[index].id]
                                            ?.answer
                                            ?.openAnswer ??
                                        "",
                                  ),
                                  width: 440,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                              )))),
                          ListView.builder(
                              shrinkWrap: true,
                              itemCount: widget
                                      .test.questions[index].variants?.length ??
                                  0,
                              itemBuilder: ((context2, index2) {
                                Answer? ra =
                                    widget.test.questions[index].rightAnswer;
                                Answer? sa =
                                    answers[widget.test.questions[index].id]
                                        ?.answer;
                                Color? saColor = sa?.closedAnswer?.contains(
                                            widget.test.questions[index]
                                                .variants?[index2]) ??
                                        false
                                    ? Colors.orange[50]
                                    : Colors.white;
                                Color? raColor = ra?.closedAnswer?.contains(
                                            widget.test.questions[index]
                                                .variants?[index2]) ??
                                        false
                                    ? Colors.green
                                    : Colors.red;
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: 400,
                                  child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (Set<MaterialState> states) {
                                          return saColor;
                                        }),
                                      ),
                                      onPressed: () {},
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(widget
                                                        .test
                                                        .questions[index]
                                                        .variants?[index2]
                                                        .text ??
                                                    ""),
                                                Container(
                                                  width: 10,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                      color: raColor,
                                                      shape: BoxShape.circle),
                                                ),
                                              ],
                                            )),
                                      )),
                                );
                              }))
                        ],
                      ),
                    );
                  }))),
    );
  }
}

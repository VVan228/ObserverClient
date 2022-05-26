import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:observer_client/entities/test/answer.dart';
import 'package:observer_client/entities/test/question.dart';
import 'package:observer_client/entities/test/question_type.dart';
import 'package:observer_client/entities/test/test.dart';
import 'package:observer_client/entities/test/variant.dart';
import 'package:observer_client/model/test_answers_model.dart';

class CreateTestAnswer extends StatefulWidget {
  CreateTestAnswer({Key? key, required this.test}) : super(key: key);

  TestAnswersModel testAnswersModel = TestAnswersModel.getInstanse();

  Test test;

  List<List<bool>> selected = [];
  List<TextEditingController> answered = [];

  Map<int, Answer> getAnswers() {
    Map<int, Answer> res = {};
    for (int i = 0; i < test.questions.length; i++) {
      Answer a = Answer();
      if (test.questions[i].questionType == QuestionType.OpenQuestionCheck) {
        a.openAnswer = answered[i].text;
      } else {
        a.closedAnswer ??= [];
        for (int j = 0; j < test.questions[i].variants!.length; j++) {
          if (selected[i][j]) {
            a.closedAnswer?.add(test.questions[i].variants![j]);
          }
        }
      }
      res[test.questions[i].id!] = a;
    }
    return res;
  }

  @override
  State<CreateTestAnswer> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<CreateTestAnswer> {
  Map<int, Answer> answers = {};

  @override
  void initState() {
    for (int i = 0; i < widget.test.questions.length; i++) {
      widget.selected.add([]);
      widget.answered.add(TextEditingController());
      for (int j = 0; j < widget.test.questions[i].variants!.length; j++) {
        widget.selected[i].add(false);
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ответ на тест " + widget.test.name),
        actions: [
          IconButton(
              onPressed: () {
                print(widget.getAnswers());
                widget.testAnswersModel
                    .saveTestAnswer(widget.getAnswers(), widget.test.id!);
                Navigator.pop(context);
              },
              icon: Icon(Icons.save))
        ],
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
                                    child: Text(name),
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
                                  child: TextFormField(
                                    controller: widget.answered[index],
                                    decoration: const InputDecoration(
                                        hintText: 'введите ответ'),
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
                                Color? color = widget.selected[index][index2]
                                    ? Colors.orange[50]
                                    : Colors.white;
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  width: 400,
                                  child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.resolveWith(
                                                (Set<MaterialState> states) {
                                          return color;
                                        }),
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          if (widget.test.questions[index]
                                                  .questionType ==
                                              QuestionType.MulVarQuestion) {
                                            widget.selected[index][index2] =
                                                !widget.selected[index][index2];
                                          } else {
                                            for (int i = 0;
                                                i <
                                                    widget
                                                        .selected[index].length;
                                                i++) {
                                              widget.selected[index][i] = false;
                                            }
                                            widget.selected[index][index2] =
                                                true;
                                          }
                                        });
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20),
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(widget
                                                    .test
                                                    .questions[index]
                                                    .variants?[index2]
                                                    .text ??
                                                "")),
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

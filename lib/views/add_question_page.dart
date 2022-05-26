import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:observer_client/entities/test/answer.dart';
import 'package:observer_client/entities/test/question_type.dart';
import 'package:observer_client/entities/test/variant.dart';

import '../entities/test/question.dart';

class AddQuestionsPage extends StatefulWidget {
  AddQuestionsPage({Key? key}) : super(key: key);

  final String title = "ДОБАВЛЕНИЕ ВОПРОСОВ";

  @override
  State<AddQuestionsPage> createState() => _CreateTestPageState();
}

class _CreateTestPageState extends State<AddQuestionsPage> {
  Adapter adapter = Adapter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(widget.title),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: () {
                    //print(adapter.getQuestions());
                    Navigator.pop(context, adapter.getQuestions());
                    //presenter.addPeopleClick();
                  },
                )),
          ],
        ),
        body: Align(
          child: SizedBox(
            width: 500,
            child: adapter,
          ),
          alignment: Alignment.topCenter,
        ));
  }
}

class Adapter extends StatefulWidget {
  Adapter({Key? key}) : super(key: key);

  final String title = "ТЕСТЫ";

  List<List<TextEditingController>> _answer_controllers = [];
  List<TextEditingController> _questions_controllers = [];
  List<List<bool>> _correct_answers = [];
  List<Question> _data = [];

  List<Question> getQuestions() {
    for (int i = 0; i < _data.length - 1; i++) {
      int len = _data[i].variants?.length ?? 1;
      _data[i].variants!.removeAt(len - 1);
      if (len - 1 == 0) {
        _data[i].questionType = QuestionType.OpenQuestionCheck;
      } else {
        List<Variant> closedAnswer = [];
        for (int j = 0; j < _correct_answers[i].length; j++) {
          if (_correct_answers[i][j]) {
            closedAnswer.add(_data[i].variants![j]);
          }
        }
        if (closedAnswer.length == 1) {
          _data[i].questionType = QuestionType.OneVarQuestion;
        } else if (closedAnswer.isNotEmpty) {
          _data[i].questionType = QuestionType.MulVarQuestion;
        }
        _data[i].rightAnswer = Answer(closedAnswer: closedAnswer);
      }
    }
    _data.removeAt(_data.length - 1);
    return _data;
  }

  @override
  State<Adapter> createState() => _AdapterState();
}

class _AdapterState extends State<Adapter> {
  Variant placeholder = Variant(text: "", id: 0);
  int variantId = 1;

  void addQuestion(Question q) {
    setState(() {
      widget._answer_controllers.add([]);
      widget._correct_answers.add([]);
      widget._questions_controllers.add(TextEditingController());
      q.questionText = "";
      //q.variants = [Variant(text: "", id: variantId)];
      q.variants = [placeholder];
      widget._data.add(q);
    });
  }

  void addWronAnswer(int i, String answer) {
    setState(() {
      //print(widget._data[i].variants);
      widget._correct_answers[i].add(false);
      widget._answer_controllers[i].add(TextEditingController());
      int len = widget._data[i].variants?.length ?? 1;
      widget._data[i].variants
          ?.insert(len - 1, Variant(text: answer, id: variantId++));
      //print(widget._data[i].variants);
    });
  }

  @override
  void initState() {
    super.initState();
    addQuestion(Question(
        scoreScale: 1,
        questionText: "",
        questionType: QuestionType.OpenQuestionCheck));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: widget._data.length,
      itemBuilder: (context, index) {
        if (index == widget._data.length - 1) {
          return GestureDetector(
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 18),
              child: DottedBorder(
                  child: const Center(child: Icon(Icons.add)),
                  strokeWidth: 1,
                  color: Colors.grey),
            ),
            onTap: () {
              addQuestion(Question(
                scoreScale: 1,
                questionText: "",
                questionType: QuestionType.OpenQuestion,
              ));
            },
          );
        }
        //return Text("question");
        final _questionController = widget._questions_controllers[index];
        return Column(
          children: [
            Card(
                color: Colors.orange[100],
                child: Padding(
                  child: TextFormField(
                    onChanged: (value) {
                      widget._data[index].questionText = value;
                      //print(widget._data[index]);
                    },
                    controller: _questionController,
                    decoration:
                        const InputDecoration(hintText: 'введите вопрос'),
                  ),
                  padding: const EdgeInsets.only(
                      left: 18, right: 18, top: 9, bottom: 9),
                )),
            ListView.builder(
              itemCount: widget._data[index].variants?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context2, index2) {
                //print(widget._data[index].variants?.length);
                widget._data[index].variants ??= [];
                if (index2 == (widget._data[index].variants?.length ?? 1) - 1) {
                  return GestureDetector(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 50, right: 50, bottom: 9),
                      child: DottedBorder(
                          child: const Center(child: Icon(Icons.add)),
                          strokeWidth: 1,
                          color: Colors.grey),
                    ),
                    onTap: () {
                      addWronAnswer(index, "");
                    },
                  );
                }
                //return Text("answer");
                final _answerController =
                    widget._answer_controllers[index][index2];
                return SizedBox(
                    width: 80,
                    height: 80,
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Card(
                            color: Colors.white,
                            child: Padding(
                              child: Container(
                                width: 350,
                                child: TextFormField(
                                  onChanged: (value) {
                                    widget._data[index].variants?[index2].text =
                                        value;
                                    print(widget._data[index].variants ??
                                        "no vars" + index2.toString());
                                  },
                                  controller: _answerController,
                                  decoration: const InputDecoration(
                                      hintText: 'введите ответ'),
                                ),
                              ),
                              padding: const EdgeInsets.only(
                                  left: 18, right: 18, top: 9, bottom: 9),
                            ),
                          ),
                          Checkbox(
                              value: widget._correct_answers[index][index2],
                              onChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    widget._correct_answers[index][index2] =
                                        value;
                                  });
                                }
                              })
                        ],
                      ),
                    ));
              },
            ),
          ],
        );
      },
    );
  }
}

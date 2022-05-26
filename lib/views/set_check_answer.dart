import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:observer_client/entities/test/question.dart';
import 'package:observer_client/entities/test/question_type.dart';
import 'package:observer_client/entities/testAnswer/scored_answer.dart';
import 'package:observer_client/model/test_answers_model.dart';

import '../entities/test/test.dart';
import '../entities/testAnswer/test_answer.dart';

class SetCheckAnswer extends StatefulWidget {
  Test test;
  TestAnswer testAnswer;
  TestAnswersModel testAnswersModel = TestAnswersModel.getInstanse();
  SetCheckAnswer({Key? key, required this.test, required this.testAnswer})
      : super(key: key);

  @override
  State<SetCheckAnswer> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<SetCheckAnswer> {
  List<Question> checkQuestions = [];
  Map<int, ScoredAnswer> mappedStudentAnswers = {};
  List<TextEditingController> controllers = [];

  List<ScoredAnswer> getAnswers() {
    List<ScoredAnswer> res = [];
    for (int i = 0; i < checkQuestions.length; i++) {
      ScoredAnswer sa = mappedStudentAnswers[checkQuestions[i].id]!;
      sa.score = int.parse(controllers[i].text);
      res.add(sa);
    }
    return res;
  }

  @override
  void initState() {
    for (Question q in widget.test.questions) {
      if (q.questionType == QuestionType.OpenQuestionCheck) {
        checkQuestions.add(q);
        controllers.add(TextEditingController());
      }
    }
    for (ScoredAnswer sa in widget.testAnswer.answers) {
      mappedStudentAnswers[sa.questionId] = sa;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                //print(getAnswers());
                widget.testAnswersModel
                    .setCheckAnswer(getAnswers(), widget.testAnswer.id);
                Navigator.pop(context);
              },
              icon: Icon(Icons.save))
        ],
        title: Text("Оценка ответа " + widget.testAnswer.student.name),
      ),
      body: Center(
          child: ConstrainedBox(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: checkQuestions.length,
            itemBuilder: (context, index) {
              String qText = checkQuestions[index].questionText;
              String aText = mappedStudentAnswers[checkQuestions[index].id]
                      ?.answer
                      ?.openAnswer ??
                  "no answer";
              return Card(
                  child: Padding(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Вопрос:"),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(7),
                        child: Text(qText,
                            style: Theme.of(context).textTheme.headline6),
                      ),
                    ),
                    Text("Ответ:"),
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(7),
                        child: Text(aText,
                            style: Theme.of(context).textTheme.headline6),
                      ),
                    ),
                    Text("Вердикт:"),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      controller: controllers[index],
                    )
                  ],
                ),
              ));
            }),
        constraints: const BoxConstraints(maxWidth: 500, minWidth: 200),
      )),
    );
  }
}

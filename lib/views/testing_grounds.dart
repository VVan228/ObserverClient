import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:observer_client/entities/global/subject.dart';
import 'package:observer_client/entities/test/answer.dart';
import 'package:observer_client/entities/test/question.dart';
import 'package:observer_client/entities/test/question_type.dart';
import 'package:observer_client/entities/test/test.dart';
import 'package:observer_client/entities/test/variant.dart';
import 'package:observer_client/entities/testAnswer/scored_answer.dart';
import 'package:observer_client/entities/user/role.dart';
import 'package:observer_client/entities/user/user.dart';
import 'package:observer_client/model/hierarchy_model.dart';
import 'package:observer_client/model/subjects_model.dart';
import 'package:observer_client/model/test_answers_model.dart';
import 'package:observer_client/model/tests_model.dart';
import 'package:observer_client/model/users_model.dart';

import '../model/auth_model.dart';

class TestingGrounds extends StatelessWidget {
  TestingGrounds({Key? key}) : super(key: key);

  var login_path = Uri.parse('http://localhost:8080/hierarchy/get/byLevel/0');
  AuthModel authImpl = AuthModel.getInstance();
  UserModel userModel = UserModel.getInstanse();
  HierarchyModel hierarchyModel = HierarchyModel.getInstanse();
  SubjectsModel subjectsModel = SubjectsModel.getInstanse();
  TestsModel testsModel = TestsModel.getInstanse();
  TestAnswersModel testAnswersModel = TestAnswersModel.getInstanse();

  TestCanvas tc = TestCanvas();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: tc),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          /*
          Test test = Test(
              timeLimit: 0,
              questions: [
                Question(
                    scoreScale: 1,
                    questionText: "questionText2",
                    questionType: QuestionType.OneVarQuestion,
                    variants: [
                      Variant(text: "right", id: 1),
                      Variant(text: "wrong", id: 2),
                      Variant(text: "wrong", id: 3),
                      Variant(text: "wrong", id: 4)
                    ],
                    rightAnswer:
                        Answer(closedAnswer: [Variant(text: "right", id: 1)]))
              ],
              subjectId: 1,
              name: "another test");
          print(await testsModel.saveTest(test, [1]));*/
          //Map<int, Answer> answers = {
          //  1: Answer(closedAnswer: [
          //    Variant(text: "var1 q1", id: 1),
          //    Variant(text: "var2 q1", id: 2)
          //  ]),
          //  2: Answer(openAnswer: "aaaaa flutter text")
          //};
          //print(await testAnswersModel.getTestAnswersForUser(false));
          //List<ScoredAnswer> scoredAnswers = [
          //  ScoredAnswer(questionId: 2, score: 50, comment: "fluttter moment")
          //];
          //print(await testAnswersModel.setCheckAnswer(scoredAnswers, 1));
          print(await userModel.saveUser(User(
              role: Role.STUDENT,
              email: "email",
              name: "name",
              password: "boba")));
        },
        child: const Icon(Icons.abc),
      ),
    );
  }
}

class TestCanvas extends StatefulWidget {
  const TestCanvas({Key? key}) : super(key: key);
  @override
  _TestCanvasState createState() => _TestCanvasState();
}

class _TestCanvasState extends State<TestCanvas> {
  String _msg = "test msg";

  void _changeMsg(String m) {
    setState(() {
      _msg = m;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(_msg);
  }
}

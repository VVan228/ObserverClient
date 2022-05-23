import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:observer_client/entities/testAnswer/scored_answer.dart';
import 'package:observer_client/entities/user/user.dart';

import '../test/test.dart';

class TestAnswer {
  int testId;
  List<ScoredAnswer> answers;
  bool validated;
  User student;
  int totalScore;
  int maxScore;
  DateTime date;
  TestAnswer({
    required this.testId,
    required this.answers,
    required this.validated,
    required this.student,
    required this.totalScore,
    required this.maxScore,
    required this.date,
  });

  TestAnswer copyWith({
    int? testId,
    List<ScoredAnswer>? answers,
    bool? validated,
    User? student,
    int? totalScore,
    int? maxScore,
    DateTime? date,
  }) {
    return TestAnswer(
      testId: testId ?? this.testId,
      answers: answers ?? this.answers,
      validated: validated ?? this.validated,
      student: student ?? this.student,
      totalScore: totalScore ?? this.totalScore,
      maxScore: maxScore ?? this.maxScore,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'testId': testId,
      'answers': answers.map((x) => x.toMap()).toList(),
      'validated': validated,
      'student': student.toMap(),
      'totalScore': totalScore,
      'maxScore': maxScore,
      'date': date.millisecondsSinceEpoch,
    };
  }

  factory TestAnswer.fromMap(Map<String, dynamic> map) {
    return TestAnswer(
      testId: map['testId']?.toInt() ?? 0,
      answers: List<ScoredAnswer>.from(
          map['answers']?.map((x) => ScoredAnswer.fromMap(x))),
      validated: map['validated'] ?? false,
      student: User.fromMap(map['student']),
      totalScore: map['totalScore']?.toInt() ?? 0,
      maxScore: map['maxScore']?.toInt() ?? 0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TestAnswer.fromJson(String source) =>
      TestAnswer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TestAnswer(testId: $testId, answers: $answers, validated: $validated, student: $student, totalScore: $totalScore, maxScore: $maxScore, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TestAnswer &&
        other.testId == testId &&
        listEquals(other.answers, answers) &&
        other.validated == validated &&
        other.student == student &&
        other.totalScore == totalScore &&
        other.maxScore == maxScore &&
        other.date == date;
  }

  @override
  int get hashCode {
    return testId.hashCode ^
        answers.hashCode ^
        validated.hashCode ^
        student.hashCode ^
        totalScore.hashCode ^
        maxScore.hashCode ^
        date.hashCode;
  }
}

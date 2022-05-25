import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:observer_client/entities/testAnswer/scored_answer.dart';
import 'package:observer_client/entities/user/user.dart';

import '../test/test.dart';

class TestAnswer {
  int id;
  int testId;
  List<ScoredAnswer> answers;
  User student;
  int totalScore;
  int maxScore;
  DateTime dateMillis;
  TestAnswer({
    required this.id,
    required this.testId,
    required this.answers,
    required this.student,
    required this.totalScore,
    required this.maxScore,
    required this.dateMillis,
  });

  TestAnswer copyWith({
    int? id,
    int? testId,
    List<ScoredAnswer>? answers,
    User? student,
    int? totalScore,
    int? maxScore,
    DateTime? dateMillis,
  }) {
    return TestAnswer(
      id: id ?? this.id,
      testId: testId ?? this.testId,
      answers: answers ?? this.answers,
      student: student ?? this.student,
      totalScore: totalScore ?? this.totalScore,
      maxScore: maxScore ?? this.maxScore,
      dateMillis: dateMillis ?? this.dateMillis,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'testId': testId,
      'answers': answers.map((x) => x.toMap()).toList(),
      'student': student.toMap(),
      'totalScore': totalScore,
      'maxScore': maxScore,
      'dateMillis': dateMillis.millisecondsSinceEpoch,
    };
  }

  factory TestAnswer.fromMap(Map<String, dynamic> map) {
    return TestAnswer(
      id: map['id']?.toInt() ?? 0,
      testId: map['testId']?.toInt() ?? 0,
      answers: List<ScoredAnswer>.from(
          map['answers']?.map((x) => ScoredAnswer.fromMap(x))),
      student: User.fromMap(map['student']),
      totalScore: map['totalScore']?.toInt() ?? 0,
      maxScore: map['maxScore']?.toInt() ?? 0,
      dateMillis: DateTime.fromMillisecondsSinceEpoch(map['dateMillis']),
    );
  }

  String toJson() => json.encode(toMap());

  factory TestAnswer.fromJson(String source) =>
      TestAnswer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TestAnswer(id: $id, testId: $testId, answers: $answers, student: $student, totalScore: $totalScore, maxScore: $maxScore, dateMillis: $dateMillis)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is TestAnswer &&
        other.id == id &&
        other.testId == testId &&
        listEquals(other.answers, answers) &&
        other.student == student &&
        other.totalScore == totalScore &&
        other.maxScore == maxScore &&
        other.dateMillis == dateMillis;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        testId.hashCode ^
        answers.hashCode ^
        student.hashCode ^
        totalScore.hashCode ^
        maxScore.hashCode ^
        dateMillis.hashCode;
  }
}

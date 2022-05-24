import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:observer_client/entities/test/question.dart';
import 'package:observer_client/entities/user/user.dart';

import '../global/subject.dart';

class Test {
  int timeLimit;
  List<Question> questions;
  int subjectId;
  String name;
  User? creator;
  Test({
    required this.timeLimit,
    required this.questions,
    required this.subjectId,
    required this.name,
    this.creator,
  });

  Test copyWith({
    int? timeLimit,
    List<Question>? questions,
    int? subjectId,
    String? name,
    User? creator,
  }) {
    return Test(
      timeLimit: timeLimit ?? this.timeLimit,
      questions: questions ?? this.questions,
      subjectId: subjectId ?? this.subjectId,
      name: name ?? this.name,
      creator: creator ?? this.creator,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'timeLimit': timeLimit,
      'questions': questions.map((x) => x.toMap()).toList(),
      'subjectId': subjectId,
      'name': name,
      'creator': creator?.toMap(),
    };
  }

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      timeLimit: map['timeLimit']?.toInt() ?? 0,
      questions: List<Question>.from(
          map['questions']?.map((x) => Question.fromMap(x))),
      subjectId: map['subjectId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      creator: map['creator'] != null ? User.fromMap(map['creator']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Test.fromJson(String source) => Test.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Test(timeLimit: $timeLimit, questions: $questions, subjectId: $subjectId, name: $name, creator: $creator)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Test &&
        other.timeLimit == timeLimit &&
        listEquals(other.questions, questions) &&
        other.subjectId == subjectId &&
        other.name == name &&
        other.creator == creator;
  }

  @override
  int get hashCode {
    return timeLimit.hashCode ^
        questions.hashCode ^
        subjectId.hashCode ^
        name.hashCode ^
        creator.hashCode;
  }
}

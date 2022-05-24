import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:observer_client/entities/test/answer.dart';
import 'package:observer_client/entities/test/question_type.dart';
import 'package:observer_client/entities/test/variant.dart';

class Question {
  //QuestionType.values.firstWhere((e) => e.name == (map['questionType']))
  List<Variant>? variants;
  Answer? rightAnswer;
  QuestionType questionType;
  int scoreScale;
  String questionText;
  Question(
      {this.variants,
      this.rightAnswer,
      required this.scoreScale,
      required this.questionText,
      required this.questionType});

  Map<String, dynamic> toMap() {
    return {
      'questionType': questionType.name,
      'variants': variants?.map((x) => x.toMap()).toList(),
      'rightAnswer': rightAnswer?.toMap(),
      'scoreScale': scoreScale,
      'questionText': questionText,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
        variants: map['variants'] != null
            ? List<Variant>.from(
                map['variants']?.map((x) => Variant.fromMap(x)))
            : null,
        rightAnswer: map['rightAnswer'] != null
            ? Answer.fromMap(map['rightAnswer'])
            : null,
        scoreScale: map['scoreScale']?.toInt() ?? 0,
        questionText: map['questionText'] ?? '',
        questionType: QuestionType.values
            .firstWhere((e) => e.name == (map['questionType'])));
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(questionType: $questionType, variants: $variants, rightAnswer: $rightAnswer, scoreScale: $scoreScale, questionText: $questionText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Question &&
        listEquals(other.variants, variants) &&
        other.rightAnswer == rightAnswer &&
        other.scoreScale == scoreScale &&
        other.questionText == questionText;
  }

  @override
  int get hashCode {
    return variants.hashCode ^
        rightAnswer.hashCode ^
        scoreScale.hashCode ^
        questionText.hashCode;
  }
}

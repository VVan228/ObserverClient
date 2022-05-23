import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:observer_client/entities/test/answer.dart';
import 'package:observer_client/entities/test/question_type.dart';
import 'package:observer_client/entities/test/variant.dart';

class Question {
  List<Variant> variants;
  Answer rightAnswer;
  QuestionType questionType;
  int scoreScale;
  String questionText;
  Question({
    required this.variants,
    required this.rightAnswer,
    required this.questionType,
    required this.scoreScale,
    required this.questionText,
  });

  Question copyWith({
    List<Variant>? variants,
    Answer? rightAnswer,
    QuestionType? questionType,
    int? scoreScale,
    String? questionText,
  }) {
    return Question(
      variants: variants ?? this.variants,
      rightAnswer: rightAnswer ?? this.rightAnswer,
      questionType: questionType ?? this.questionType,
      scoreScale: scoreScale ?? this.scoreScale,
      questionText: questionText ?? this.questionText,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'variants': variants.map((x) => x.toMap()).toList(),
      'rightAnswer': rightAnswer.toMap(),
      'questionType': questionType.name,
      'scoreScale': scoreScale,
      'questionText': questionText,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      variants:
          List<Variant>.from(map['variants']?.map((x) => Variant.fromMap(x))),
      rightAnswer: Answer.fromMap(map['rightAnswer']),
      questionType: map['questionType'],
      scoreScale: map['scoreScale']?.toInt() ?? 0,
      questionText: map['questionText'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Question(variants: $variants, rightAnswer: $rightAnswer, questionType $questionType scoreScale: $scoreScale, questionText: $questionText)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Question &&
        listEquals(other.variants, variants) &&
        other.rightAnswer == rightAnswer &&
        other.questionType == questionType &&
        other.scoreScale == scoreScale &&
        other.questionText == questionText;
  }

  @override
  int get hashCode {
    return variants.hashCode ^
        rightAnswer.hashCode ^
        questionType.hashCode ^
        scoreScale.hashCode ^
        questionText.hashCode;
  }
}

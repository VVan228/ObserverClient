import 'dart:convert';

import '../test/answer.dart';

class ScoredAnswer {
  Answer answer;
  int questionId;
  int score;
  String comment;
  ScoredAnswer({
    required this.answer,
    required this.questionId,
    required this.score,
    required this.comment,
  });

  ScoredAnswer copyWith({
    Answer? answer,
    int? questionId,
    int? score,
    String? comment,
  }) {
    return ScoredAnswer(
      answer: answer ?? this.answer,
      questionId: questionId ?? this.questionId,
      score: score ?? this.score,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'answer': answer.toMap(),
      'questionId': questionId,
      'score': score,
      'comment': comment,
    };
  }

  factory ScoredAnswer.fromMap(Map<String, dynamic> map) {
    return ScoredAnswer(
      answer: Answer.fromMap(map['answer']),
      questionId: map['questionId']?.toInt() ?? 0,
      score: map['score']?.toInt() ?? 0,
      comment: map['comment'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ScoredAnswer.fromJson(String source) =>
      ScoredAnswer.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ScoredAnswer(answer: $answer, questionId: $questionId, score: $score, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ScoredAnswer &&
        other.answer == answer &&
        other.questionId == questionId &&
        other.score == score &&
        other.comment == comment;
  }

  @override
  int get hashCode {
    return answer.hashCode ^
        questionId.hashCode ^
        score.hashCode ^
        comment.hashCode;
  }
}

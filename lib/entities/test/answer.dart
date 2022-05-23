import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:observer_client/entities/test/variant.dart';

class Answer {
  List<Variant> closedAnswer;
  String openAnswer;
  Answer({
    required this.closedAnswer,
    required this.openAnswer,
  });

  Answer copyWith({
    List<Variant>? closedAnswer,
    String? openAnswer,
  }) {
    return Answer(
      closedAnswer: closedAnswer ?? this.closedAnswer,
      openAnswer: openAnswer ?? this.openAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'closedAnswer': closedAnswer.map((x) => x.toMap()).toList(),
      'openAnswer': openAnswer,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      closedAnswer: List<Variant>.from(
          map['closedAnswer']?.map((x) => Variant.fromMap(x))),
      openAnswer: map['openAnswer'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source));

  @override
  String toString() =>
      'Answer(closedAnswer: $closedAnswer, openAnswer: $openAnswer)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Answer &&
        listEquals(other.closedAnswer, closedAnswer) &&
        other.openAnswer == openAnswer;
  }

  @override
  int get hashCode => closedAnswer.hashCode ^ openAnswer.hashCode;
}

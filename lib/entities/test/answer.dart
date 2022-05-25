import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:observer_client/entities/test/variant.dart';

class Answer {
  int? id;
  List<Variant>? closedAnswer;
  String? openAnswer = "";
  Answer({
    this.id,
    this.closedAnswer,
    this.openAnswer,
  });

  Answer copyWith({
    int? id,
    List<Variant>? closedAnswer,
    String? openAnswer,
  }) {
    return Answer(
      id: id ?? this.id,
      closedAnswer: closedAnswer ?? this.closedAnswer,
      openAnswer: openAnswer ?? this.openAnswer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'closedAnswer': closedAnswer?.map((x) => x.toMap()).toList(),
      'openAnswer': openAnswer,
    };
  }

  factory Answer.fromMap(Map<String, dynamic> map) {
    return Answer(
      id: map['id']?.toInt(),
      closedAnswer: map['closedAnswer'] != null
          ? List<Variant>.from(
              map['closedAnswer']?.map((x) => Variant.fromMap(x)))
          : null,
      openAnswer: map['openAnswer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Answer.fromJson(String source) => Answer.fromMap(json.decode(source));

  @override
  String toString() =>
      'Answer(id: $id, closedAnswer: $closedAnswer, openAnswer: $openAnswer)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Answer &&
        other.id == id &&
        listEquals(other.closedAnswer, closedAnswer) &&
        other.openAnswer == openAnswer;
  }

  @override
  int get hashCode => id.hashCode ^ closedAnswer.hashCode ^ openAnswer.hashCode;
}

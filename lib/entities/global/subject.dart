import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:observer_client/entities/user/user.dart';

class Subject {
  String name;
  int? id;
  List<User>? teachers;
  Subject({
    required this.name,
    this.id,
    this.teachers,
  });

  Subject copyWith({
    String? name,
    int? id,
    List<User>? teachers,
  }) {
    return Subject(
      name: name ?? this.name,
      id: id ?? this.id,
      teachers: teachers ?? this.teachers,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'id': id,
      'teachers': teachers?.map((x) => x.toMap()).toList(),
    };
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      name: map['name'] ?? '',
      id: map['id']?.toInt(),
      teachers: map['teachers'] != null
          ? List<User>.from(map['teachers']?.map((x) => User.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Subject.fromJson(String source) =>
      Subject.fromMap(json.decode(source));

  @override
  String toString() => 'Subject(name: $name, id: $id, teachers: $teachers)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is Subject &&
        other.name == name &&
        other.id == id &&
        listEquals(other.teachers, teachers);
  }

  @override
  int get hashCode => name.hashCode ^ id.hashCode ^ teachers.hashCode;
}

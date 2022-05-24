import 'dart:convert';

class SubjectPlain {
  int id;
  String name;
  SubjectPlain({
    required this.id,
    required this.name,
  });

  SubjectPlain copyWith({
    int? id,
    String? name,
  }) {
    return SubjectPlain(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  factory SubjectPlain.fromMap(Map<String, dynamic> map) {
    return SubjectPlain(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectPlain.fromJson(String source) =>
      SubjectPlain.fromMap(json.decode(source));

  @override
  String toString() => 'SubjectPlain(id: $id, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubjectPlain && other.id == id && other.name == name;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode;
}

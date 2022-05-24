import 'dart:convert';

import 'package:observer_client/entities/global/H.dart';

class HGroup extends H {
  String name;
  HGroup({
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {'name': name, 'children': children?.map((x) => x.toMap()).toList()};
  }

  factory HGroup.fromMap(Map<String, dynamic> map) {
    return HGroup(
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HGroup.fromJson(String source) => HGroup.fromMap(json.decode(source));

  @override
  String toString() => 'HGroup(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HGroup && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}

import 'dart:convert';

import 'package:collection/collection.dart';

class H {
  List<H>? children;
  H({
    this.children,
  });

  H copyWith({
    List<H>? children,
  }) {
    return H(
      children: children ?? this.children,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'children': children?.map((x) => x.toMap()).toList(),
    };
  }

  factory H.fromMap(Map<String, dynamic> map) {
    return H(
      children: map['children'] != null
          ? List<H>.from(map['children']?.map((x) => H.fromMap(x)))
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory H.fromJson(String source) => H.fromMap(json.decode(source));

  @override
  String toString() => 'H(children: $children)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other is H && listEquals(other.children, children);
  }

  @override
  int get hashCode => children.hashCode;
}

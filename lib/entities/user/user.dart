import 'dart:convert';

import 'package:observer_client/entities/user/role.dart';

class User {
  Role role;
  String email;
  String name;
  User({
    required this.role,
    required this.email,
    required this.name,
  });

  User copyWith({
    Role? role,
    String? email,
    String? name,
  }) {
    return User(
      role: role ?? this.role,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role.name,
      'email': email,
      'name': name,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      role: map['role'],
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() => 'User(role: $role, email: $email, name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.role == role &&
        other.email == email &&
        other.name == name;
  }

  @override
  int get hashCode => role.hashCode ^ email.hashCode ^ name.hashCode;
}

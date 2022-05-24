import 'dart:convert';

import 'package:observer_client/entities/user/role.dart';

class User {
  Role role;
  String email;
  String name;
  int? id;
  User({
    required this.role,
    required this.email,
    required this.name,
    this.id,
  });

  static Role getRoleByString(String role) {
    return Role.values.firstWhere((e) => e.name == (role));
  }

  User copyWith({
    Role? role,
    String? email,
    String? name,
    int? id,
  }) {
    return User(
      role: role ?? this.role,
      email: email ?? this.email,
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role.name,
      'email': email,
      'name': name,
      'id': id,
    };
  }

  factory User.fromMap(dynamic map) {
    Role role = Role.values.firstWhere((e) => e.name == (map['role']));
    String email = map['email'] ?? '';
    String name = map['name'] ?? '';
    int id = map['id']?.toInt() ?? 0;
    //print(role);
    //print(email);
    //print(name);
    //print(id);
    return User(
      role: role,
      email: email,
      name: name,
      id: id,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  @override
  String toString() {
    return 'User(role: $role, email: $email, name: $name, id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.role == role &&
        other.email == email &&
        other.name == name &&
        other.id == id;
  }

  @override
  int get hashCode {
    return role.hashCode ^ email.hashCode ^ name.hashCode ^ id.hashCode;
  }
}

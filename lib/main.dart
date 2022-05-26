import 'package:flutter/material.dart';
import 'package:observer_client/model/auth_model.dart';
import 'package:observer_client/views/admin_page.dart';
import 'package:observer_client/views/sign_in_page.dart';
import 'package:observer_client/views/teacher_page.dart';
import 'package:observer_client/views/testing_grounds.dart';

import 'entities/user/role.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: const StateCheck());
  }
}

class StateCheck extends StatelessWidget {
  const StateCheck({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AuthModel auth = AuthModel.getInstance();
    var isLogged = auth.isLogged();

    return FutureBuilder<Role?>(
      future: isLogged,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Role? res = snapshot.data;
          if (res != null && res == Role.ADMIN) {
            return const AdminPage();
          } else if (res != null && res == Role.TEACHER) {
            return TeacherPage();
          } else {
            return SignInPage();
          }
        } else {
          return SignInPage();
        }
      },
    );
  }
}

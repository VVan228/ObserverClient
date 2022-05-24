import 'package:flutter/material.dart';
import 'package:observer_client/model/auth_model.dart';
import 'package:observer_client/views/sign_in_page.dart';
import 'package:observer_client/views/testing_grounds.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("running");
    AuthModel auth = AuthModel.getInstance();
    var isLogged = auth.isLogged();

    //Widget page = (await auth.isLogged())?

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: FutureBuilder<bool>(
        future: isLogged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool? res = snapshot.data;
            if (res != null && res) {
              return TestingGrounds();
            } else {
              return SignInPage();
            }
          } else {
            return const SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

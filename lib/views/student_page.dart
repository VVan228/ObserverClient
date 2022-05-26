import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:observer_client/views/sign_in_page.dart';
import 'package:observer_client/views/tests_list.dart';

import '../model/auth_model.dart';

class StudentPage extends StatefulWidget {
  StudentPage({Key? key}) : super(key: key);
  AuthModel auth = AuthModel.getInstance();

  @override
  State<StudentPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<StudentPage> {
  static List<Widget> _widgetOptions = <Widget>[
    TestsList(),
    Text("data2"),
  ];
  int selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Тесты"),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () async {
            await widget.auth.logout(context);
            widget.auth.isLogged();
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignInPage()),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.text_snippet_rounded),
            label: 'Tests',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Answers',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: Center(
        child: _widgetOptions.elementAt(selectedIndex),
      ),
    );
  }
}

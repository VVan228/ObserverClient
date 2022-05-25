import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:observer_client/entities/user/role.dart';
import 'package:observer_client/model/auth_model.dart';
import 'package:observer_client/presenters/admin_page_impl.dart';
import 'package:observer_client/presenters/user_list_impl.dart';
import 'package:observer_client/views/interfaces/admin_page_view.dart';
import 'package:observer_client/views/interfaces/student_list_view.dart';
import 'package:observer_client/views/sign_in_page.dart';
import 'package:observer_client/views/student_list.dart';
import 'package:observer_client/views/subjects_list.dart';
import 'package:observer_client/views/teacher_list.dart';
import 'package:observer_client/views/testing_grounds.dart';

import '../entities/global/subject.dart';
import '../entities/user/user.dart';
import 'hierarchy_page.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthModel auth = AuthModel.getInstance();

    //Widget page = (await auth.isLogged())?

    return Scaffold(
        body: MyStatefulWidget(
      auth: auth,
    ));
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key? key, required this.auth}) : super(key: key);
  AuthModel auth;

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget>
    implements AdminPageView {
  AdminPageImpl presenter = AdminPageImpl();
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  Role? currentRole = Role.STUDENT;

  UserListImpl presenterStudent = UserListImpl();
  UserListImpl presenterTeacher = UserListImpl();

  static const List<Widget> _widgetOptions = <Widget>[
    StudentList(),
    TeacherList(),
    SubjectList(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          {
            currentRole = Role.STUDENT;
            break;
          }
        case 1:
          {
            currentRole = Role.TEACHER;
            break;
          }
        case 2:
          {
            currentRole = null;
          }
      }
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          presenter.addClicked();
        },
        tooltip: 'add student',
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Пункт управления'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_tree_rounded),
            tooltip: 'hierarchy',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HierarchyPage()),
              );
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.logout),
          tooltip: 'logout',
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Teachers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subject),
            label: 'Subjects',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void initState() {
    presenter.setView(this);
    super.initState();
  }

  @override
  bool isSubjectListPageOpened() {
    return currentRole == null;
  }

  @override
  Future<Subject?> getSubjectData() async {
    if (currentRole != null) {
      return null;
    }
    final _nameController = TextEditingController();
    Subject? subject = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Добавить предмет"),
          content: SingleChildScrollView(
            child: TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'имя'),
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Theme.of(context).colorScheme.background;
                }),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Colors.white;
                }),
              ),
              child: const Text('отмена'),
              onPressed: () {
                Navigator.pop(context, null);
              },
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Colors.white;
                }),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Theme.of(context).colorScheme.secondary;
                }),
              ),
              child: const Text('ок'),
              onPressed: () {
                // debugPrint(_nameController.text + " alert");
                Navigator.pop(context, Subject(name: _nameController.text));
              },
            ),
          ],
        );
      },
    );
    return subject;
  }

  @override
  Future<User?> getUserData() async {
    if (currentRole == null) {
      return null;
    }
    String text = "";
    Role notNullCurrentRole = Role.STUDENT;
    if (currentRole == Role.STUDENT) {
      text = "Зарегестрировать студента";
      notNullCurrentRole = Role.STUDENT;
    }
    if (currentRole == Role.TEACHER) {
      text = "Зарегестрировать преподавателя";
      notNullCurrentRole = Role.TEACHER;
    }
    final _nameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordControleer = TextEditingController();
    User? user = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(text),
          content: SingleChildScrollView(
              child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'имя'),
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'почта'),
              ),
              TextFormField(
                controller: _passwordControleer,
                decoration: const InputDecoration(hintText: 'пароль'),
              ),
            ],
          )),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Theme.of(context).colorScheme.background;
                }),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Colors.white;
                }),
              ),
              child: const Text('отмена'),
              onPressed: () {
                Navigator.pop(context, null);
              },
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Colors.white;
                }),
                backgroundColor: MaterialStateProperty.resolveWith(
                    (Set<MaterialState> states) {
                  return Theme.of(context).colorScheme.secondary;
                }),
              ),
              child: const Text('ок'),
              onPressed: () {
                // debugPrint(_nameController.text + " alert");
                Navigator.pop(
                    context,
                    User(
                        role: notNullCurrentRole,
                        email: _emailController.text,
                        name: _nameController.text,
                        password: _passwordControleer.text));
              },
            ),
          ],
        );
      },
    );
    return user;
  }
}

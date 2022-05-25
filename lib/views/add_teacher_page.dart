import 'package:flutter/material.dart';
import 'package:observer_client/entities/global/subject.dart';
import 'package:observer_client/model/subjects_model.dart';
import 'package:observer_client/presenters/add_teacher_impl.dart';
import 'package:observer_client/views/admin_page.dart';
import 'package:observer_client/views/interfaces/add_teacher_view.dart';

import '../entities/user/user.dart';
import '../model/auth_model.dart';
import '../presenters/sign_in_impl.dart';
import 'interfaces/sign_in_view.dart';

class AddTeacherPage extends StatefulWidget {
  int subjectId;

  AddTeacherPage({Key? key, required this.subjectId}) : super(key: key);

  @override
  _AddTeacherPage createState() => _AddTeacherPage();
}

class _AddTeacherPage extends State<AddTeacherPage> implements AddTeacherView {
  List<User?> teachers = [null];
  AddTeacherImpl presenter = AddTeacherImpl();
  String title = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            presenter.addClicked();
          },
          child: Icon(Icons.add),
        ),
        appBar: AppBar(title: Text(title)),
        body: Center(
            child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500, minWidth: 200),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: teachers.length,
              itemBuilder: (context, index) {
                if (index == teachers.length - 1) {
                  return IconButton(
                    icon: Icon(Icons.update),
                    onPressed: () {
                      presenter.update();
                    },
                  );
                }
                String name = teachers[index]?.name ?? '';
                String email = teachers[index]?.email ?? '';
                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        Text(email,
                            style: TextStyle(
                                color: Theme.of(context).disabledColor)),
                      ],
                    ),
                  ),
                );
              }),
        )));
  }

  Future<User?> getTeacher(List<User> teachers) async {
    User? user = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Добавить преподавателя"),
          content: SingleChildScrollView(
            child: Container(
              width: 500,
              height: 500,
              child: ListView.builder(
                  itemCount: teachers.length,
                  itemBuilder: (context, index) {
                    String name = teachers[index].name;
                    String email = teachers[index].email;
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context, teachers[index]);
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(email,
                                  style: TextStyle(
                                      color: Theme.of(context).disabledColor)),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
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
          ],
        );
      },
    );
    return user;
  }

  @override
  void setTitle(String t) {
    setState(() {
      title = t;
    });
  }

  @override
  void addUser(User user) {
    setState(() {
      teachers.insert(0, user);
    });
  }

  @override
  void removeAllUsers() {
    setState(() {
      teachers = [null];
    });
  }

  @override
  void initState() {
    presenter.setView(this);
    presenter.initialized();
    super.initState();
  }

  @override
  int getSubjectId() {
    return widget.subjectId;
  }
}

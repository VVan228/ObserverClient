import 'package:flutter/material.dart';
import 'package:observer_client/entities/user/role.dart';
import 'package:observer_client/model/users_model.dart';
import 'package:observer_client/presenters/user_list_impl.dart';
import 'package:observer_client/views/interfaces/student_list_view.dart';

import '../entities/user/user.dart';

class TeacherList extends StatefulWidget {
  final Role role = Role.TEACHER;

  const TeacherList({Key? key}) : super(key: key);

  //Role role = Role.STUDENT;

  @override
  State<TeacherList> createState() => _StudentListState();
}

class _StudentListState extends State<TeacherList> implements UserListView {
  int _selectedIndex = 0;
  UserModel userModel = UserModel.getInstanse();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<User?> users = [null];

  UserListImpl presenter = UserListImpl();

  @override
  void initState() {
    presenter.setView(this);
    presenter.initialized();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Role getRole() {
    return widget.role;
  }

  @override
  void addUser(User user) {
    setState(() {
      users.insert(0, user);
    });
  }

  @override
  void removeAllUsers() {
    users = [null];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ConstrainedBox(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: users.length,
          itemBuilder: (context, index) {
            if (index == users.length - 1) {
              return IconButton(
                icon: Icon(Icons.update),
                onPressed: () {
                  presenter.update();
                },
              );
            }
            String name = users[index]?.name ?? '';
            String email = users[index]?.email ?? '';
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
                        style:
                            TextStyle(color: Theme.of(context).disabledColor)),
                  ],
                ),
              ),
            );
          }),
      constraints: const BoxConstraints(maxWidth: 500, minWidth: 200),
    ));
  }
}

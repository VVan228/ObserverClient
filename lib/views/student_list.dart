import 'package:flutter/material.dart';
import 'package:observer_client/entities/global/group.dart';
import 'package:observer_client/entities/user/role.dart';
import 'package:observer_client/model/users_model.dart';
import 'package:observer_client/presenters/user_list_impl.dart';
import 'package:observer_client/views/interfaces/student_list_view.dart';

import '../entities/user/user.dart';

class StudentList extends StatefulWidget {
  final Role role = Role.STUDENT;

  const StudentList({Key? key}) : super(key: key);

  //Role role = Role.STUDENT;

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> implements UserListView {
  int _selectedIndex = 0;
  UserModel userModel = UserModel.getInstanse();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<User> users = [User(role: Role.STUDENT, email: "", name: "")];

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
    users = [User(role: Role.STUDENT, email: "", name: "")];
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
            String name = users[index].name;
            String email = users[index].email;
            int id = users[index].id ?? 0;
            return GestureDetector(
                onTap: () {
                  presenter.openGroupDialog(id);
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
                ));
          }),
      constraints: const BoxConstraints(maxWidth: 500, minWidth: 200),
    ));
  }

  @override
  Future<int?> getGroupId(List<Group> groups) async {
    int? groupId = await showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Выбрать группу"),
          content: SingleChildScrollView(
            child: Container(
              width: 500,
              height: 500,
              child: ListView.builder(
                  itemCount: groups.length,
                  itemBuilder: (context, index) {
                    String name = groups[index].name;
                    return GestureDetector(
                      onTap: () {
                        Navigator.pop(context, groups[index].id);
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
    return groupId;
  }
}

import 'package:flutter/material.dart';
import 'package:observer_client/entities/global/subject.dart';
import 'package:observer_client/entities/global/subject_plain.dart';
import 'package:observer_client/entities/user/role.dart';
import 'package:observer_client/model/users_model.dart';
import 'package:observer_client/presenters/user_list_impl.dart';
import 'package:observer_client/views/add_teacher_page.dart';
import 'package:observer_client/views/interfaces/student_list_view.dart';
import 'package:observer_client/views/interfaces/subject_list_view.dart';

import '../entities/user/user.dart';
import '../presenters/subject_list_impl.dart';

class SubjectList extends StatefulWidget {
  const SubjectList({Key? key}) : super(key: key);
  @override
  State<SubjectList> createState() => _SubjectList();
}

class _SubjectList extends State<SubjectList> implements SubjectListView {
  int _selectedIndex = 0;
  UserModel userModel = UserModel.getInstanse();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<SubjectPlain?> subjects = [null];

  SubjectListImpl presenter = SubjectListImpl();

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
  void addSubject(SubjectPlain subject) {
    setState(() {
      subjects.insert(0, subject);
    });
  }

  @override
  void removeAllSubjects() {
    subjects = [null];
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ConstrainedBox(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            if (index == subjects.length - 1) {
              return IconButton(
                icon: Icon(Icons.update),
                onPressed: () {
                  presenter.update();
                },
              );
            }
            String name = subjects[index]?.name ?? '';
            int subjectId = subjects[index]?.id ?? 1;
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddTeacherPage(
                            subjectId: subjectId,
                          )),
                );
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
      constraints: const BoxConstraints(maxWidth: 500, minWidth: 200),
    ));
  }
}

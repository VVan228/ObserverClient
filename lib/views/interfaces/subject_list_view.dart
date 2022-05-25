import 'package:observer_client/entities/global/subject_plain.dart';

import '../../entities/global/subject.dart';
import '../../entities/user/role.dart';
import '../../entities/user/user.dart';

abstract class SubjectListView {
  void addSubject(SubjectPlain subject);
  void removeAllSubjects();
}

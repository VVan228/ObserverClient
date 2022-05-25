import 'package:observer_client/entities/user/user.dart';

abstract class AdminPageView {
  Future<User?> getUserData();
}

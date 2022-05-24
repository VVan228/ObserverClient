import 'package:observer_client/model/auth_model.dart';

class TestAnswersModel {
  static TestAnswersModel? obj;
  int page = 0;
  AuthModel authImpl = AuthModel.getInstance();

  static getInstanse() {
    obj ??= TestAnswersModel();
    return obj;
  }
}

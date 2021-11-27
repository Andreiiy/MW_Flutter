



import 'package:math_world/models/user.dart';

class AppData {

  static final AppData _instance = AppData._internal();

  // passes the instantiation to the _instance object
  factory AppData() => _instance;

  AppData._internal() {
    //_myVariable = 0;
  }

  User? user;

}
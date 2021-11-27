

import 'package:math_world/models/user.dart';
import 'package:pmvvm/view_model.dart';

class RegisterationViewModel extends ViewModel {
  User? user;

  // Optional
  @override
  void init() {
    // It's called after the ViewModel is constructed
  }

  // Optional
  @override
  void onBuild() {
    // It's called everytime the view is rebuilt
  }

  void registration() {

    notifyListeners();
  }
}
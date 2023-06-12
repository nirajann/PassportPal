import 'package:flutter/material.dart';
import 'package:passportpal/models/user.dart';

import 'package:passportpal/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMthods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMthods.getUserDetails();
    _user = user;

    notifyListeners();
  }
}

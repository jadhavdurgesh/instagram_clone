import 'package:flutter/material.dart';
import 'package:instagram_firebase/models/user.dart';
import 'package:instagram_firebase/resources/auth_methods.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  AuthMethods _authMethods = AuthMethods();
  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}

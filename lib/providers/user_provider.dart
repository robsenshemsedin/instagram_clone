import 'package:flutter/widgets.dart';
import 'package:instagram_clone/resources/resources_export.dart';
import 'package:instagram_clone/models/models_export.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetail();
    _user = user;
    notifyListeners();
  }
}

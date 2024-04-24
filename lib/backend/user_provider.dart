import 'package:flutter/widgets.dart';
import 'package:photo_gram/screens/auth_service.dart';
import 'package:photo_gram/backend/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthService auth = AuthService();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await auth.getUserDetails();
    _user = user;
    notifyListeners();
  }
}

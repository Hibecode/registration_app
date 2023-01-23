import 'package:flutter/cupertino.dart';

import '../model/user.dart';

class UserProvider extends ChangeNotifier{

  User _user = User(firstName: '', lastName: '', email: '', phoneNumber: '', password: '');

  User get user => _user;

  void setUser (User user){
    _user = user;
    notifyListeners();
  }
}
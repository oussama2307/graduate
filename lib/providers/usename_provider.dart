import 'package:flutter/material.dart';

class UsernameProvider extends ChangeNotifier {
  dynamic user = "";

  void changename({required dynamic details}) {
    user = details;
    notifyListeners();
  }

  void changepfp({required String? url}) {
    user["profile_picture"] = url;
    notifyListeners();
  }

  void updatetheuser(
      {required String name, required String password, required String city}) {
    user["name"] = name;
    user["password"] = password;
    user["city"] = city;
    notifyListeners();
  }
}

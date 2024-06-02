import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  String _language = "ar";

  String get language => _language;

  void changelang({required String lang}) {
    _language = lang;
    notifyListeners();
  }

  Locale get locale => Locale(_language);
}

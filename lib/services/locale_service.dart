import 'package:flutter/material.dart';

enum AppLanguage { ar, en, de }

class LocaleService extends ChangeNotifier {
  static final LocaleService instance = LocaleService._();
  LocaleService._();

  AppLanguage _language = AppLanguage.ar;
  AppLanguage get language => _language;

  void setLanguage(AppLanguage lang) {
    _language = lang;
    notifyListeners();
  }
}

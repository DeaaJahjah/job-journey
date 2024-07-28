import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  Locale? locale; //= Locale(DatabaseManager.load('language'));

  LanguageProvider({this.locale});

  changeLanguge(Locale newLanguage) {
    locale = (newLanguage.languageCode == 'en') ? const Locale('en') : const Locale('ar');

    notifyListeners();
  }
}

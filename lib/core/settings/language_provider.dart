import 'package:flutter/material.dart';
import 'package:job_journey/core/utils/shared_pref.dart';
// import 'package:job_journey/core/utils/shared_pref.dart';

class LanguageProvider extends ChangeNotifier {
  Locale? locale;

  LanguageProvider({this.locale});

  changeLanguge(Locale newLanguage) {
    locale = (newLanguage.languageCode == 'en') ? const Locale('en') : const Locale('ar');
    SharedPreferencesManager().saveString('language', newLanguage.languageCode);
    notifyListeners();
  }
}

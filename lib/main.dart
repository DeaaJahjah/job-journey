import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_journey/core/settings/language_provider.dart';
import 'package:job_journey/core/utils/shared_pref.dart';
import 'package:job_journey/features/app.dart';
import 'package:job_journey/firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPreferencesManager().init();
  if (!SharedPreferencesManager().containsKey('language')) {
    SharedPreferencesManager().saveString('language', 'ar');
  }
  runApp(ChangeNotifierProvider<LanguageProvider>(
    create: (_) => LanguageProvider(locale: Locale(SharedPreferencesManager().getString('language') ?? 'ar')),
    child: const App(
        // client: client,
        ),
  ));
}

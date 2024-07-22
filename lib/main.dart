import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:job_journey/core/utils/shared_pref.dart';
import 'package:job_journey/features/app.dart';
import 'package:job_journey/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SharedPreferencesManager().init();

  runApp(const App(
      // client: client,
      ));
}

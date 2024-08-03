import 'package:flutter/material.dart';
import 'package:job_journey/features/company/screens/job_overview_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JobsOverViewScreen();
   
  }
}

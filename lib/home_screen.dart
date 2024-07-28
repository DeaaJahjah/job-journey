import 'package:flutter/material.dart';
import 'package:job_journey/core/config/extensions/firebase.dart';
import 'package:job_journey/features/auth/Services/authentecation_service.dart';
import 'package:job_journey/features/company/screens/job_overview_screen.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const JobsOverViewScreen();
    // Scaffold(
    //   appBar: AppBar(title: const Text('home')),
    //   body: Center(
    //     child: Column(
    //       children: [
    //         Text(context.firebaseUser!.email ?? ''),
    //         IconButton(
    //             onPressed: () async {
    //               await FlutterFireAuthServices().signOut(context);
    //             },
    //             icon: const Icon(Icons.logout))
    //       ],
    //     ),
    //   ),
    // );
  }
}

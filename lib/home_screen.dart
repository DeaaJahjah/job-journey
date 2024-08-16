import 'package:flutter/material.dart';
import 'package:job_journey/features/chat/providers/video_call_provider.dart';
import 'package:job_journey/features/company/screens/job_overview_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<VideoCallProvider>().getAgoraSetup();

    return const JobsOverViewScreen();
   
  }
}

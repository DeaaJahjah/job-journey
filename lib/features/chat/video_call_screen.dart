import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:job_journey/core/config/widgets/custom_progress.dart';
import 'package:job_journey/core/keys.dart';
import 'package:job_journey/features/chat/providers/video_call_provider.dart';
import 'package:provider/provider.dart';

class VideoCallScreen extends StatefulWidget {
  static const routeName = '/video-call-screen';
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  // Instantiate the client
  AgoraClient? client;

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () async {
        final agoraSetupModel = context.read<VideoCallProvider>().agoraSetupModel;

        client = AgoraClient(
          agoraConnectionData: AgoraConnectionData(
            appId: AGORA_APP_ID,
            channelName: agoraSetupModel!.channelName,
            tempToken: agoraSetupModel.tempToken,
          ),
        );
        await client!.initialize();
        setState(() {});
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Video Call>>>'),
      // ),
      body: SafeArea(
        child: PopScope(
          canPop: false,
          child: client == null || !client!.isInitialized
              ? const CustomProgress()
              : Stack(
                  children: [
                    AgoraVideoViewer(
                      client: client!,
                      showNumberOfUsers: true,
                      layoutType: Layout.oneToOne,
                    ),
                    AgoraVideoButtons(
                      client: client!,
                      autoHideButtons: true,

                      // enabledButtons: const [],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}

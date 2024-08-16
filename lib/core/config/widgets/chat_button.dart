import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/custom_progress.dart';
import 'package:job_journey/core/config/widgets/custom_snackbar.dart';
import 'package:job_journey/features/chat/chat_page.dart';
import 'package:job_journey/features/chat/chat_provider.dart';
import 'package:provider/provider.dart';

class ChatButton extends StatelessWidget {
  final bool fromProfile;
  final String userId;
  final String userName;
  const ChatButton({
    super.key,
    this.fromProfile = false,
    required this.userId,
    required this.userName,

  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
        builder: (_, provider, child) => GestureDetector(
              onTap: () async {
                await provider
                    .createChatRoom(userId: userId, userName: userName)
                    .then((_) async {
                  if (provider.dataState == DataState.done) {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          room: provider.room!,
                        ),
                      ),
                    );
                  } else {
                    showErrorSnackBar(context, context.loc.anErrorAccourdWhileCreatingChat);
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                decoration: fromProfile
                    ? null
                    : BoxDecoration(border: Border.all(color: blue), borderRadius: BorderRadius.circular(10)),
                child: provider.dataState == DataState.loading
                    ? CustomProgress(
                        color: fromProfile ? white : blue,
                      )
                    : GradientIcon(
                        offset: Offset.zero,
                        gradient: LinearGradient(colors: [fromProfile ? white : lightBlue, fromProfile ? white : blue]),
                        icon: Icons.chat,
                      ),
              ),
            ));
  }
}

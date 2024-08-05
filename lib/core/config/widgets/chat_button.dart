import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:job_journey/core/config/constant/constant.dart';

class ChatButton extends StatelessWidget {
  final void Function() onTap;
  const ChatButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(color: blue), borderRadius: BorderRadius.circular(10)),
        child: const GradientIcon(
          offset: Offset.zero,
          gradient: LinearGradient(colors: [lightBlue, blue]),
          icon: Icons.chat,
        ),
      ),
    );
  }
}

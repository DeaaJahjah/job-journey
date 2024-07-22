import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final Color color;
  final Color textColor;
  const ElevatedButtonCustom(
      {super.key, this.textColor = blue, required this.onPressed, required this.text, this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(color),
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: textColor, fontFamily: font, fontWeight: FontWeight.w600, fontSize: 14),
          )),
    );
  }
}

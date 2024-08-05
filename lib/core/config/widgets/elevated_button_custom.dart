import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final Function()? onPressed;
  final String text;
  final bool blueGradientButton;
  final Color textColor;
  const ElevatedButtonCustom(
      {super.key, this.textColor = blue, required this.onPressed, required this.text, this.blueGradientButton = true});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          height: 50,
          // width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: blueGradientButton ? [lightBlue, blue] : [lightpurple, purple])),
          child: Text(
            text,
            style: TextStyle(color: textColor, fontFamily: font, fontWeight: FontWeight.w600, fontSize: 14),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';

class CustomProgress extends StatelessWidget {
  final Color color;
  const CustomProgress({super.key, this.color = blue});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: color,
    ));
  }
}

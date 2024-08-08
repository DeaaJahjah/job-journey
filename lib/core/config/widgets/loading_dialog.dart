import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/widgets/custom_progress.dart';

void showLoadingDialog(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return const Padding(
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: Dialog(
            alignment: Alignment.center,
            surfaceTintColor: gray,
            elevation: 8,
            backgroundColor: darkGray,
            insetPadding: EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              height: 100,
              child: CustomProgress(),
            ),
          ),
        );
      });
}

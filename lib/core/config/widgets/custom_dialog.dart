import 'package:flutter/material.dart';

class CustomDialogs {
  BuildContext context;
  CustomDialogs(this.context);

  Future<void> showbottomSheetDialog({required Widget widget, AnimationController? animation}) {
    return showModalBottomSheet<Widget>(
      sheetAnimationStyle: AnimationStyle(
          curve: Curves.fastOutSlowIn,
          reverseCurve: Curves.linear,
          reverseDuration: const Duration(milliseconds: 350),
          duration: const Duration(milliseconds: 350)),
      // constraints: const BoxConstraints(maxHeight: 400),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      transitionAnimationController: animation,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              child: IntrinsicHeight(
                child: widget,
              ),
            ),
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';

class TextFieldCustom extends StatelessWidget {
  int? maxLine = 1;
  final String text;
  final TextEditingController controller;
  final IconData? icon;
  TextInputType? keyboardType;
  void Function(String)? onChanged;
  TextFieldCustom(
      {super.key,
      required this.text,
      required this.controller,
      this.icon,
      this.keyboardType = TextInputType.text,
      this.maxLine,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: white,
        fontFamily: font,
        fontSize: 12,
      ),
      controller: controller,
      enableSuggestions: true,
      decoration: InputDecoration(
          fillColor: darkGray,
          filled: true,
          hintStyle: const TextStyle(color: gray, fontFamily: font, fontSize: 16, fontWeight: FontWeight.normal),
          suffixIcon: Icon(
            icon,
            color: blue,
          ),
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: darkGray),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: darkGray),
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: text,
          iconColor: background,
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          errorStyle: const TextStyle(height: 0),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: blue, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle: const TextStyle(color: white, fontFamily: font, fontSize: 14, fontWeight: FontWeight.normal)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}

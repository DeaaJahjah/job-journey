import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final bool validate;
  final void Function()? onTap;
  final String text;
  final IconData? icon;
  final Color? iconColor;
  final void Function()? onIconTap;
  final bool readOnly;
  final int? maxLine;
  const TextFieldCustom(
      {super.key,
      required this.text,
      this.controller,
      this.onIconTap,
      this.icon,
      this.iconColor,
      this.validate = true,
      this.onTap,
      this.keyboardType = TextInputType.text,
      this.maxLine = 1,
      this.readOnly = false,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      maxLines: maxLine,
      readOnly: readOnly,
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
          suffixIcon: InkWell(
            onTap: onIconTap,
            child: Icon(
              icon,
              color: iconColor ?? blue,
            ),
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
        if ((value == null || value.isEmpty) && validate) {
          return '';
        }
        return null;
      },
      onChanged: onChanged,
    );
  }
}

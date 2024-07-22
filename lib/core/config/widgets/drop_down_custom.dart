import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';

class DropDownCustom extends StatefulWidget {
  final List<String> categories;
  final String selectedItem;
  final Function(String?)? onChanged;
  const DropDownCustom({super.key, required this.categories, required this.selectedItem, this.onChanged});

  @override
  State<DropDownCustom> createState() => _DropDownCustomState();
}

class _DropDownCustomState extends State<DropDownCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 40,
      // width: 120,
      decoration: BoxDecoration(
        border: Border.all(color: blue),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          dropdownColor: white,
          elevation: 10,
          iconEnabledColor: blue,
          style: meduimTextStyle,
          alignment: AlignmentDirectional.center,
          focusColor: blue,
          isDense: true,
          value: widget.selectedItem,
          onChanged: widget.onChanged,
          items: widget.categories.map((String items) {
            return DropdownMenuItem(
              value: items,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Text(items),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

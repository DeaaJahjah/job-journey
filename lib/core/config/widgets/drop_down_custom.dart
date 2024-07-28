import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';

class DropDownCustom extends StatefulWidget {
  final List<String> categories;
  final String? selectedItem;
  final String hint;
  final Function(String?)? onChanged;
  const DropDownCustom(
      {super.key, required this.categories, required this.hint, required this.selectedItem, this.onChanged});

  @override
  State<DropDownCustom> createState() => _DropDownCustomState();
}

class _DropDownCustomState extends State<DropDownCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: darkGray,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            dropdownColor: Colors.grey[800],
            elevation: 10,
            // iconEnabledColor: blue,
            style: meduimTextStyle,
            alignment: AlignmentDirectional.center,
            focusColor: blue,
            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  widget.hint,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white),
                ),
              ),
            ),
            isDense: true,
            value: widget.selectedItem,
            onChanged: widget.onChanged,
            items: widget.categories.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Text(
                    item,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

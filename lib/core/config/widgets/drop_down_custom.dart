import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/utils/shared_pref.dart';

class DropDownCustom extends StatefulWidget {
  final List<String> categories;
  final String? selectedItem;
  final String hint;
  final IconData? icon;
  final Function(String?)? onChanged;
  const DropDownCustom(
      {super.key, this.icon, required this.categories, required this.hint, required this.selectedItem, this.onChanged});

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

            padding: const EdgeInsets.symmetric(horizontal: 12),
            dropdownColor: brown,
            elevation: 10,
            // iconEnabledColor: blue,
            style: meduimTextStyle,
            borderRadius: BorderRadius.circular(10),
            alignment: AlignmentDirectional.center,
            focusColor: darkGray,
            // padding: const EdgeInsets.symmetric(horizontal: 10),

            hint: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: SharedPreferencesManager().isArabic() ? Alignment.centerRight : Alignment.centerLeft,
                child: Text(
                  widget.hint,
                  // textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: white),
                ),
              ),
            ),
            isDense: true,
            icon: widget.icon == null
                ? null
                : Icon(
                    widget.icon,
                    color: blue,
                    size: 19,
                  ),
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

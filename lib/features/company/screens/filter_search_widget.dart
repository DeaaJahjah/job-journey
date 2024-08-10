import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/drop_down_custom.dart';
import 'package:job_journey/core/config/widgets/text_field_custome.dart';
import 'package:job_journey/core/utils/shared_pref.dart';
import 'package:job_journey/features/company/providers/company_provider.dart';
import 'package:provider/provider.dart';

class FilterSearchWidget extends StatefulWidget {
  const FilterSearchWidget({super.key});

  @override
  State<FilterSearchWidget> createState() => _FilterSearchWidgetState();
}

class _FilterSearchWidgetState extends State<FilterSearchWidget> {
  final search = TextEditingController();
  String? selectedType;
  String? selectedCity;

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !context.select<CompanyProvider, bool>((value) => value.isSearching)
        ? Text(context.loc.jobs)
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFieldCustom(
                  onChanged: (value) {
                    context
                        .read<CompanyProvider>()
                        .searchAndFilter(search: value, city: selectedCity, jobType: selectedType);
                  },
                  controller: search,
                  text: SharedPreferencesManager().isArabic() ? 'ابحث عن اسم وظيفة' : "Search for job ",
                  icon: Icons.close,
                  onIconTap: () {
                    setState(() {
                      selectedCity = null;
                      selectedType = null;
                      search.clear();
                    });
                    context.read<CompanyProvider>().changeSearch(false);
                    context.read<CompanyProvider>().clearSearch();
                  }).animate().slide(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Row(
                  children: [
                    Expanded(
                        child: DropDownCustom(
                      icon: Icons.location_pin,
                      categories: ['الكل'] + cities,
                      hint: context.loc.location,
                      selectedItem: selectedCity,
                      onChanged: (item) {
                        setState(() {
                          selectedCity = item == 'الكل' ? null : item;
                        });
                        context.read<CompanyProvider>().searchAndFilter(
                            search: search.text, city: item == 'الكل' ? null : item, jobType: selectedType);
                      },
                    ).animate().slide(
                              begin: Offset(SharedPreferencesManager().isArabic() ? 1.5 : -1.5, 0),
                              duration: const Duration(milliseconds: 500),
                            )),
                    const SizedBox(width: 10),
                    Expanded(
                        child: DropDownCustom(
                      icon: Icons.work_rounded,
                      categories: ['الكل'] + jobTypes,
                      hint: context.loc.jobType,
                      selectedItem: selectedType,
                      onChanged: (item) {
                        setState(() {
                          selectedType = item == 'الكل' ? null : item;
                        });
                        context.read<CompanyProvider>().searchAndFilter(
                            search: search.text, city: selectedCity, jobType: item == 'الكل' ? null : item);
                      },
                    ).animate().slide(
                              begin: Offset(SharedPreferencesManager().isArabic() ? -1.5 : 1.5, 0),
                              duration: const Duration(milliseconds: 500),
                            )),
                  ],
                ),
              ),
            ],
          );
  }
}

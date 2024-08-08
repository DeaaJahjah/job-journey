import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/custom_snackbar.dart';
import 'package:job_journey/core/utils/shared_pref.dart';
import 'package:job_journey/features/company/models/category.dart';
import 'package:job_journey/features/job_seeker/providers/job_seeker_provider.dart';
import 'package:provider/provider.dart';

class TopicsSubscriptionScreen extends StatefulWidget {
  static const routeName = '/topics-subscription-screen';
  const TopicsSubscriptionScreen({super.key});

  @override
  State<TopicsSubscriptionScreen> createState() => _TopicsSubscriptionScreenState();
}

class _TopicsSubscriptionScreenState extends State<TopicsSubscriptionScreen> {
  @override
  void initState() {
    selectedTopics = context.read<JobSeekerProvider>().jobSeekerModel?.topicsSubscription ?? [];
    // isFirst = false;
    super.initState();
  }

  bool isFirst = true;
  List<Category> selectedTopics = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.topicsSubscription),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Text(
            context.loc.selectTopicsOfYourInterest,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white),
          ),
          sizedBoxLarge,
          SizedBox(
            height: 500,
            width: 400,
            child: Selector<JobSeekerProvider, DataState>(
                selector: (_, provider) => provider.dataState,
                builder: (context, dataState, _) {
                  return FilterListWidget<Category>(
                    listData: industries,
                    hideHeader: true,
                    hideCloseIcon: true,
                    hideSearchField: true,
                    hideSelectedTextCount: true,
                    backgroundColor: background,
                    selectedListData: selectedTopics,
                    choiceChipBuilder: <Category>(context, item, isSelected) => Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            margin: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10), color: isSelected == true ? purple : brown),
                            child: Text(
                              SharedPreferencesManager().isArabic() ? item.name : item.enName,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white),
                            ))
                        .animate()
                        .shimmer(
                            delay: const Duration(milliseconds: 100),
                            duration: isSelected == false
                                ? const Duration(microseconds: 0)
                                : const Duration(milliseconds: 400)),
                    themeData: FilterListThemeData(
                      context,
                      controlButtonBarTheme: ControlButtonBarThemeData(context,
                          margin: const EdgeInsets.symmetric(horizontal: 0),
                          controlButtonTheme: const ControlButtonThemeData(
                            elevation: 14,
                            padding: EdgeInsets.symmetric(horizontal: 100),
                            primaryButtonTextStyle: meduimTextStyle,
                          ),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [lightBlue, blue],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(15))),
                      backgroundColor: background,
                    ),
                    controlButtons: const [],
                    applyButtonText: dataState == DataState.loading
                        ? SharedPreferencesManager().isArabic()
                            ? "يتم التعديل..."
                            : "Updating..."
                        : context.loc.save,
                    onApplyButtonClick: (list) {
                      final jobSeekerProvider = context.read<JobSeekerProvider>();
                      if (jobSeekerProvider.dataState == DataState.loading) return;
                      if (list?.isNotEmpty ?? false) {
                        selectedTopics = list!;
                        jobSeekerProvider
                            .updateTopicsSubscription(
                                seekerId: jobSeekerProvider.jobSeekerModel!.id!, topicsSubscription: list)
                            .then((_) {
                          if (jobSeekerProvider.dataState == DataState.failure) {
                            showErrorSnackBar(context, context.loc.somethingWentWrong);
                          }
                          showSuccessSnackBar(context, context.loc.topicsSubscriptionsUpdatedSuccessfully);
                        });
                      } else {
                        showErrorSnackBar(
                            context,
                            SharedPreferencesManager().isArabic()
                                ? "يجب ان يتم اختيار عنصر واحد على الأقل"
                                : "Please select at least one item");
                      }
                    },
                    choiceChipLabel: (item) {
                      return SharedPreferencesManager().isArabic() ? item!.name : item!.enName;
                    },
                    validateSelectedItem: (list, val) {
                      return list!.contains(val);
                    },
                    onItemSearch: (user, query) {
                      return true;
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}

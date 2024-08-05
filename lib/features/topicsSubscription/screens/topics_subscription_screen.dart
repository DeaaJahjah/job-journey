import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:filter_list/filter_list.dart';
import 'package:job_journey/features/company/models/category.dart';

class TopicsSubscriptionScreen extends StatelessWidget {
  static const routeName = '/topics-subscription-screen';
  const TopicsSubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final selectedTopics = ModalRoute.of(context)!.settings.arguments as List<Category>;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
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
            child: FilterListWidget<Category>(
              listData: industries,
              hideHeader: true,
              hideCloseIcon: true, hideSearchField: true,
              hideSelectedTextCount: true,
              backgroundColor: background,

              selectedListData: [], // selectedTopics,
              choiceChipBuilder: (context, item, isSelected) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.all(8),
                  // alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10), color: isSelected == true ? purple : brown),
                  child: Text(
                    item.name,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white),
                  )),
              themeData: FilterListThemeData(context,
                  controlButtonBarTheme: ControlButtonBarThemeData(context,
                      margin: const EdgeInsets.symmetric(horizontal: 0),
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      controlButtonTheme: const ControlButtonThemeData(
                          primaryButtonTextStyle: meduimTextStyle, backgroundColor: Colors.transparent),
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [lightBlue, blue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15))),
                  backgroundColor: background,
                  choiceChipTheme: ChoiceChipThemeData(
                      margin: const EdgeInsets.all(10),
                      backgroundColor: brown,
                      selectedBackgroundColor: purple,
                      textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white))),
              controlButtons: const [],
              applyButtonText: context.loc.save,

              onApplyButtonClick: (list) {},
              choiceChipLabel: (item) {
                return item!.name;
              },
              validateSelectedItem: (list, val) {
                return list!.contains(val);
              },
              onItemSearch: (user, query) {
                return true;
              },
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/elevated_button_custom.dart';
import 'package:job_journey/features/auth/screens/comapny_sign_up_screen.dart';
import 'package:job_journey/features/job_seeker/screens/job_seeker_sign_up_screen.dart';

class SelectAccountTypeScreen extends StatefulWidget {
  static const routeName = '/select-account-type';
  const SelectAccountTypeScreen({super.key});

  @override
  State<SelectAccountTypeScreen> createState() => _SelectAccountTypeScreenState();
}

class _SelectAccountTypeScreenState extends State<SelectAccountTypeScreen> {
  int selectedType = -1;
  @override
  Widget build(BuildContext context) {
    final types = ['شركة', 'باحث عن عمل'];
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('اختر نوع الحساب', style: largTextStyle.copyWith(fontSize: 20)),
          sizedBoxLarge,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: blue.withOpacity(.1)),
            child: Column(children: [
              SelectTypeWidget(
                title: types[0],
                isSelected: 1 == selectedType,
                onTap: () {
                  setState(() {});
                  selectedType = 1;
                },
              ),
              SelectTypeWidget(
                title: types[1],
                isSelected: 2 == selectedType,
                onTap: () {
                  setState(() {});
                  selectedType = 2;
                },
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: ElevatedButtonCustom(
                
                textColor: white,
                onPressed: () {
                  if (selectedType == 1) {
                    Navigator.of(context).pushNamed(ComapnySignUpScreen.routeName);
                    return;
                  }
                  if (selectedType == 2) {
                    Navigator.of(context).pushNamed(JobSeekerSignUpScreen.routeName);
                    return;
                  }
                },
                text: context.loc.next),
          )
        ],
      ),
    );
  }
}

//select Type Widget
class SelectTypeWidget extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool isSelected;
  const SelectTypeWidget({super.key, required this.title, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: isSelected ? blue : onbackground, borderRadius: BorderRadius.circular(10)),
        child: Text(
          title,
          style: meduimTextStyle,
        ),
      ),
    );
  }
}

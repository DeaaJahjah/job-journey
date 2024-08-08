import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/firebase.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/settings/language_provider.dart';
import 'package:job_journey/features/auth/Services/authentecation_service.dart';
import 'package:job_journey/features/chat/rooms.dart';
import 'package:job_journey/features/company/providers/company_provider.dart';
import 'package:job_journey/features/company/screens/company_profile_screen.dart';
import 'package:job_journey/features/job_seeker/providers/job_seeker_provider.dart';
import 'package:job_journey/features/job_seeker/screens/job_seeker_profile_screen.dart';
import 'package:job_journey/features/topicsSubscription/screens/topics_subscription_screen.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final List<DropdownMenuItem<String>> items = [
    const DropdownMenuItem(
      value: 'en',
      child: Text('EN'),
    ),
    const DropdownMenuItem(
      value: 'ar',
      child: Text('AR'),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: darkGray,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!context.isCompanyAccount)
            Consumer<JobSeekerProvider>(builder: (context, provider, child) {
              final user = provider.jobSeekerModel;
              return UserAccountsDrawerHeader(
                arrowColor: lightBlue,
                onDetailsPressed: () {
                  Navigator.of(context).pushNamed(JobSeekerProfileScreen.routeName);

                  // Navigator.of(context).pushNamed(CompanyProfileScreen.routeName);
                },
                accountName: Text(user?.name ?? 'لا يوجد', style: meduimTextStyle),
                accountEmail: Text(user?.email ?? 'لا يوجد', style: meduimTextStyle),
                currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      user == null || user.profilePicture == null ? null : NetworkImage(user.profilePicture!),
                ),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide.none), gradient: LinearGradient(colors: [lightBlue, blue])),
              );
            })
          else
            Consumer<CompanyProvider>(builder: (context, provider, child) {
              final user = provider.profile;
              return UserAccountsDrawerHeader(
                arrowColor: lightBlue,
                onDetailsPressed: () {
                  // Navigator.of(context).pushNamed(JobSeekerProfileScreen.routeName);

                  Navigator.of(context).pushNamed(CompanyProfileScreen.routeName);
                },
                accountName: Text(user?.name ?? 'لا يوجد', style: meduimTextStyle),
                accountEmail: Text(user?.email ?? 'لا يوجد', style: meduimTextStyle),
                currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      user == null || user.profilePicture == null ? null : NetworkImage(user.profilePicture!),
                ),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide.none), gradient: LinearGradient(colors: [lightBlue, blue])),
              );
            }),
          ListTile(
            leading: const Icon(Icons.message, color: white),
            title: Text(context.loc.conversations, style: meduimTextStyle),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RoomsPage(),
              ));

              // Handle add service action
            },
          ),
          if (!context.isCompanyAccount)
            ListTile(
                leading: const Icon(Icons.interests_rounded, color: white),
                title: Text(context.loc.topicsSubscription, style: meduimTextStyle),
                onTap: () {
                  Navigator.of(context).pushNamed(TopicsSubscriptionScreen.routeName);
                }),
          ListTile(
            leading: const Icon(
              Icons.language,
              color: white,
            ),
            title: Text(
              context.loc.language,
              style: meduimTextStyle,
            ),
            trailing: SizedBox(
              width: 75,
              child: DropdownButtonFormField<String>(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  iconSize: 20,
                  style: smallTextStyle,
                  iconEnabledColor: gray,
                  focusColor: Colors.transparent,
                  decoration: const InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  dropdownColor: brown,
                  items: items,
                  borderRadius: BorderRadius.circular(15),
                  value: context.watch<LanguageProvider>().locale?.languageCode,
                  onChanged: (selectedLanguage) {
                    setState(() {
                      Provider.of<LanguageProvider>(context, listen: false)
                          .changeLanguge(Locale(selectedLanguage == 'en' ? 'en' : 'ar'));
                    });
                  }),
            ),
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: white),
            title: Text(context.loc.signOut, style: meduimTextStyle),
            onTap: () async {
              // SharedPrefs.prefs.clear();

              await FlutterFireAuthServices().signOut(context);
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/firebase.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/features/auth/Services/authentecation_service.dart';
import 'package:job_journey/features/chat/rooms.dart';
import 'package:job_journey/features/company/screens/company_profile_screen.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
                  // Navigator.of(context).pushNamed(CompanyProfileScreen.routeName);
                },
                accountName: Text(user!.name ?? 'لا يوجد', style: meduimTextStyle),
                accountEmail: Text(user.email ?? 'لا يوجد', style: meduimTextStyle),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(user.profilePicture!),
                ),
                decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide.none), gradient: LinearGradient(colors: [lightBlue, blue])),
              );
            }),
          ListTile(
            leading: const Icon(Icons.message, color: white),
            title: const Text('المحادثات', style: meduimTextStyle),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RoomsPage(),
              ));

              // Handle add service action
            },
          ),
          ListTile(
            leading: const Icon(Icons.add, color: white),
            title: const Text('اضافة خدمة', style: meduimTextStyle),
            onTap: () {
              // Navigator.of(context).pushNamed(AddPostScreen.routeName);

              // Handle add service action
            },
          ),
          ListTile(
            leading: const Icon(Icons.build, color: white),
            title: const Text('خدماتي', style: meduimTextStyle),
            onTap: () {
              // Handle my services action
              // Navigator.of(context).pushNamed(MyPostsScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.interests_rounded, color: white),
            title: Text(context.loc.topicsSubscription, style: meduimTextStyle),
            onTap: () {
              Navigator.of(context).pushNamed(TopicsSubscriptionScreen.routeName);
              // Handle my favorites action
            },
          ),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.logout, color: white),
            title: const Text('تسجيل خروج', style: meduimTextStyle),
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

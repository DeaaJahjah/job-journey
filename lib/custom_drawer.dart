import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/firebase.dart';
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
          UserAccountsDrawerHeader(
            arrowColor: lightBlue,
            onDetailsPressed: () {
              if (context.isCompanyAccount) {
                Navigator.of(context).pushNamed(CompanyProfileScreen.routeName);
                return;
              }
              // Navigator.of(context).pushNamed(JobSeekerProfileScreen.routeName);
            },
            accountName: Text(context.firebaseUser!.displayName ?? 'لا يوجد', style: meduimTextStyle),
            accountEmail: Text(context.firebaseUser!.email ?? 'لا يوجد', style: meduimTextStyle),
            currentAccountPicture:
                //  context.logedInUser!.photoURL == null || context.logedInUser!.photoURL == ''
                //     ?
                const CircleAvatar(
              child: Icon(Icons.person),
            ),
            // : CircleAvatar(
            //     backgroundImage: NetworkImage(context.logedInUser!.photoURL!),
            //   ),

            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide.none), gradient: LinearGradient(colors: [lightBlue, blue])),
          ),
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
            leading: const Icon(Icons.favorite, color: white),
            title: const Text('المفضلة', style: meduimTextStyle),
            onTap: () {
              // Navigator.of(context).pushNamed(FavouriteScreen.routeName);
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

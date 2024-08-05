import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/custom_progress.dart';
import 'package:job_journey/features/job_seeker/providers/job_seeker_provider.dart';
import 'package:provider/provider.dart';

class JobSeekerProfileScreen extends StatefulWidget {
  static const routeName = '/job-seeker-profile-screen';
  const JobSeekerProfileScreen({super.key});

  @override
  State<JobSeekerProfileScreen> createState() => _JobSeekerProfileScreenState();
}

class _JobSeekerProfileScreenState extends State<JobSeekerProfileScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      //get profile
      // context.read<JobSeekerProvider>().
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<JobSeekerProvider>(builder: (context, provider, child) {
        if (provider.dataState == DataState.loading) {
          return const CustomProgress();
        }
        if (provider.profile == null) {
          return Center(
            child: Text(
              context.loc.noData,
              style: largTextStyle,
            ),
          );
        }
        final profile = provider.profile!;
        return SafeArea(
          child: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              title: Text(
                context.loc.profile,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white, fontWeight: FontWeight.bold),
              ),
              foregroundColor: white,
              elevation: 8,
              pinned: true,
              snap: false,
              floating: false,
              expandedHeight: 250.0,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1.5,
                centerTitle: true,
                background: SizedBox.expand(
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.vertical(bottom: Radius.circular(25)),
                        gradient: LinearGradient(
                            colors: [lightBlue, blue], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [lightBlue, blue]),
                              shape: BoxShape.circle,
                              border: Border(
                                  right: BorderSide(width: 4, color: white),
                                  left: BorderSide(width: 4, color: white),
                                  bottom: BorderSide(width: 4, color: white))),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              profile.profilePicture ??
                                  "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/company-logo-design-template-5746111ce930e4340aa34a9eb626a302_screen.jpg?ts=1671431883",
                            ),
                            radius: 50,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          profile.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontSize: 18, color: white, fontWeight: FontWeight.bold),
                          // ),
                        ),
                        Text(
                          profile.location,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              centerTitle: true,
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 16, right: 16, bottom: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.email_rounded,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            context.loc.email,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                        child: Text(
                          profile.email,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white, letterSpacing: 1),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        endIndent: 20,
                        indent: 20,
                        thickness: .5,
                        height: 30,
                      ),
                      // SizedBox(height: 20),
                      Row(
                        children: [
                          const Icon(Icons.phone_iphone_rounded, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(
                            context.loc.phoneNumber,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                        child: Text(
                          profile.phoneNumber,
                          textDirection: TextDirection.ltr,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white, letterSpacing: 1),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        endIndent: 20,
                        indent: 20,
                        thickness: .5,
                      ),
                      sizedBoxSmall,
                      Row(
                        children: [
                          const Icon(Icons.description_rounded, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(
                            context.loc.personalSummary,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                        child: Text(
                          profile.aboutYou,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white, letterSpacing: 1),
                        ),
                      ),
                      const Divider(
                        color: Colors.grey,
                        endIndent: 20,
                        indent: 20,
                        thickness: .5,
                      ),
                      sizedBoxSmall,
                      Row(
                        children: [
                          const Icon(Icons.bar_chart_rounded, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(
                            context.loc.skills,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: profile.skills?.length ?? 0,
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        profile.skills?[index] ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(color: white, letterSpacing: 1),
                                      ),
                                    ],
                                  ))),
                      const Divider(
                        color: Colors.grey,
                        endIndent: 20,
                        indent: 20,
                        thickness: .5,
                      ),
                      sizedBoxSmall,
                      Row(
                        children: [
                          const Icon(Icons.handshake_rounded, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(
                            context.loc.softSkills,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: profile.softSkills?.length ?? 0,
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        profile.softSkills?[index] ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(color: white, letterSpacing: 1),
                                      ),
                                    ],
                                  ))),

                      const Divider(
                        color: Colors.grey,
                        endIndent: 20,
                        indent: 20,
                        thickness: .5,
                      ),
                      sizedBoxSmall,
                      Row(
                        children: [
                          const Icon(Icons.school_rounded, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(
                            context.loc.certificates,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white),
                          ),
                        ],
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: profile.certificates?.length ?? 0,
                              itemBuilder: (context, index) => Row(
                                    children: [
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        profile.certificates?[index] ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(color: white, letterSpacing: 1),
                                      ),
                                    ],
                                  ))),

                      const Divider(
                        color: Colors.grey,
                        endIndent: 20,
                        indent: 20,
                        thickness: .5,
                      ),
                      sizedBoxSmall,
                      Row(
                        children: [
                          const Icon(Icons.school_rounded, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(
                            context.loc.languages,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: profile.languages?.length ?? 0,
                          itemBuilder: (context, index) => Row(
                            children: [
                              Container(
                                height: 8,
                                width: 8,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                profile.languages?[index] ?? '',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white, letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const Divider(
                        color: Colors.grey,
                        endIndent: 20,
                        indent: 20,
                        thickness: .5,
                      ),
                      sizedBoxSmall,
                      Row(
                        children: [
                          const Icon(Icons.category_rounded, color: Colors.grey),
                          const SizedBox(width: 5),
                          Text(
                            context.loc.topicsSubscription,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: profile.topicsSubscription?.length ?? 0,
                          itemBuilder: (context, index) => Row(
                            children: [
                              Container(
                                height: 8,
                                width: 8,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                profile.topicsSubscription?[index].name ?? '',
                                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white, letterSpacing: 1),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            )
          ]),
        );
      }),
    );
  }
}

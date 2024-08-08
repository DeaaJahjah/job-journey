import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/core/config/extensions/firebase.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/custom_progress.dart';
import 'package:job_journey/core/config/widgets/custom_snackbar.dart';
import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';
import 'package:job_journey/features/job_seeker/providers/job_seeker_provider.dart';
import 'package:job_journey/features/job_seeker/screens/analyze_profile_screen.dart';
import 'package:job_journey/features/job_seeker/screens/edit_job_seeker_profile_screen.dart';
import 'package:job_journey/features/job_seeker/screens/profile_without_shimmer.dart';
import 'package:job_journey/features/job_seeker/services/analyze_profile_service.dart';
import 'package:provider/provider.dart';

class JobSeekerProfileScreen extends StatefulWidget {
  static const routeName = '/job-seeker-profile-screen';
  const JobSeekerProfileScreen({super.key});

  @override
  State<JobSeekerProfileScreen> createState() => _JobSeekerProfileScreenState();
}

class _JobSeekerProfileScreenState extends State<JobSeekerProfileScreen> with SingleTickerProviderStateMixin {
  bool _isAnalyzerEnabled = false;

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final seekerId = ModalRoute.of(context)!.settings.arguments as String?;
      if (seekerId != null) {
        context.read<JobSeekerProvider>().getJobSeeker(userId: seekerId);
      }
      context.read<AnalyzeProfileProvider>().initGemini();
      //get profile
      // context.read<JobSeekerProvider>().
    });
    super.initState();
  }

  // @override
  // void dispose() {
  //   _analyzerController?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<JobSeekerProvider>(builder: (context, provider, child) {
        if (provider.dataState == DataState.loading) {
          return const CustomProgress();
        }
        if (provider.jobSeekerModel == null) {
          return Center(
            child: Text(
              context.loc.noData,
              style: largTextStyle,
            ),
          );
        }
        final profile = provider.jobSeekerModel!;
        return SafeArea(
          child: CustomScrollView(slivers: <Widget>[
            SliverAppBar(
              title: Text(
                context.loc.profile,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white, fontWeight: FontWeight.bold),
              ),
              actions: [
                if (!context.isCompanyAccount)
                  GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(EditJobSeekerProfileScreen.routeName);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.edit, color: white),
                      ))
              ],
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
                    child: !_isAnalyzerEnabled
                        ? ProfileBodyWithOutShimer(profile: profile)
                        : ProfileBodyWithShimer(profile: profile)),
              ]),
            )
          ]),
        );
      }),
      floatingActionButton: Consumer<AnalyzeProfileProvider>(builder: (_, provider, child) {
        return provider.dataState == DataState.loading
            ? const CircularProgressIndicator(
                color: blue,
              )
            : GestureDetector(
                onTap: () async {
                  setState(() {
                    _isAnalyzerEnabled = true;
                    // _analyzerController!.forward();
                  });
                  // await Future.delayed(const Duration(seconds: 1));

                  await provider.analyzeMyProfile(
                      cv: context.read<JobSeekerProvider>().jobSeekerModel!.toJson().toString());

                  setState(() {
                    _isAnalyzerEnabled = false;
                    // _analyzerController!
                    //   ..stop()
                    //   ..reset();
                  });
                  if (provider.dataState == DataState.done) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AnalyzeProfileScreen(
                        data: provider.data,
                      ),
                    ));
                  } else {
                    showErrorSnackBar(context, 'error');
                  }
                },
                child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(begin: Alignment.centerLeft, colors: [lightpurple, purple]),
                    ),
                    child: const Icon(
                      Icons.analytics,
                      color: white,
                      size: 30,
                    ).animate().rotate()),
              );
      }),
    );
  }
}

class ProfileBodyWithShimer extends StatefulWidget {
  const ProfileBodyWithShimer({
    super.key,
    required this.profile,
  });

  final JobSeekerModel profile;

  @override
  State<ProfileBodyWithShimer> createState() => _ProfileBodyWithShimerState();
}

class _ProfileBodyWithShimerState extends State<ProfileBodyWithShimer> with SingleTickerProviderStateMixin {
  AnimationController? _analyzerController;
  @override
  void initState() {
    _analyzerController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    super.initState();
  }

  @override
  void deactivate() {
    _analyzerController?.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            widget.profile.email,
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
            widget.profile.phoneNumber,
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
            widget.profile.summary,
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
                itemCount: widget.profile.skills?.length ?? 0,
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
                        Expanded(
                          child: Text(
                            widget.profile.skills?[index] ?? '',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white, letterSpacing: 1),
                          ),
                        ),
                    ]))),
        // const Divider(
        //   color: Colors.grey,
        //   endIndent: 20,
        //   indent: 20,
        //   thickness: .5,
        // ),
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
                itemCount: widget.profile.skills?.length ?? 0,
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
                                      Expanded(
                                        child: Text(
                            widget.profile.skills?[index] ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(color: white, letterSpacing: 1),
                                        ),
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
                itemCount: widget.profile.softSkills?.length ?? 0,
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
                                      Expanded(
                                        child: Text(
                            widget.profile.softSkills?[index] ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(color: white, letterSpacing: 1),
                                        ),
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
                itemCount: widget.profile.certificates?.length ?? 0,
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
                                      Expanded(
                                        child: Text(
                            widget.profile.certificates?[index] ?? '',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(color: white, letterSpacing: 1),
                                        ),
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
                          const Icon(Icons.language, color: Colors.grey),
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
                itemCount: widget.profile.languages?.length ?? 0,
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
                              Expanded(
                                child: Text(
                            widget.profile.languages?[index] ?? '',
                                  style:
                                      Theme.of(context).textTheme.bodyLarge?.copyWith(color: white, letterSpacing: 1),
                                ),
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
                itemCount: widget.profile.topicsSubscription?.length ?? 0,
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
                              Expanded(
                                child: Text(
                            widget.profile.topicsSubscription?[index].name ?? '',
                                  style:
                                      Theme.of(context).textTheme.bodyLarge?.copyWith(color: white, letterSpacing: 1),
                                ),
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
                itemCount: widget.profile.certificates?.length ?? 0,
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
                          widget.profile.certificates?[index] ?? '',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white, letterSpacing: 1),
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
            itemCount: widget.profile.languages?.length ?? 0,
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
                  widget.profile.languages?[index] ?? '',
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
            itemCount: widget.profile.topicsSubscription?.length ?? 0,
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
                  widget.profile.topicsSubscription?[index].name ?? '',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white, letterSpacing: 1),
                ),
              ],
            ),
          ),
        ),
      ],
    )
        .animate(
          autoPlay: true,
          controller: _analyzerController,
          onComplete: (controller) {
            _analyzerController!.repeat(reverse: true).then(
              (value) {
                setState(() {});
              },
            );
          },
        )
        .shimmer(
            duration: 900.milliseconds,
            colors: [
              lightBlue,
              lightpurple,
              white,
            ],
            angle: 250,
            curve: Curves.easeIn);
    // .fade(curve: Curves.fastEaseInToSlowEaseOut);
  }
}

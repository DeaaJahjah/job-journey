import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/custom_progress.dart';
import 'package:job_journey/features/company/models/job_model.dart';
import 'package:job_journey/features/company/screens/add_job_screen.dart';
import 'package:job_journey/features/company/screens/job_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:job_journey/features/company/providers/company_provider.dart';
import 'package:show_up_animation/show_up_animation.dart';

class JobsOverViewScreen extends StatefulWidget {
  static const routeName = '/jobs-overview-screen';
  const JobsOverViewScreen({super.key});

  @override
  State<JobsOverViewScreen> createState() => _JobsOverViewScreenState();
}

class _JobsOverViewScreenState extends State<JobsOverViewScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<CompanyProvider>().getJobs();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      drawer: const Drawer(),
      appBar: AppBar(
        toolbarHeight: 90,
        title: Text(context.loc.jobs),
        automaticallyImplyLeading: false,
        leading: const Icon(
          Icons.table_rows_sharp,
          color: Colors.white,
        ),
      ),
      body: Consumer<CompanyProvider>(builder: (context, provider, _) {
        final jobs = provider.myJobs;
        return provider.dataState == DataState.loading
            ? const CustomProgress()
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  return ShowUpAnimation(
                    animationDuration: const Duration(milliseconds: 400),
                    child: JobCard(
                      job: jobs[index],
                    ),
                  );
                },
                separatorBuilder: (__, _) {
                  return const SizedBox(height: 5);
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: blue,
        onPressed: () {
          Navigator.of(context).pushNamed(AddJobScreen.routeName);
        },
        child: const Icon(Icons.add, color: background),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final JobModel job;

  const JobCard({
    super.key,
    required this.job,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(JobDetailsScreen.routeName, arguments: job.id);
      },
      child: Container(
        // elevation: 9,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(blurRadius: 1, spreadRadius: 2.5, color: Colors.grey[900]!, offset: Offset(0, 1))],
          borderRadius: BorderRadius.circular(15),
          // gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
          //   Color.fromARGB(255, 252, 149, 76),
          //   Color.fromARGB(255, 249, 120, 120),
          // ])
          color: background, // Color.fromARGB(255, 31, 31, 31),
        ),
        margin: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // if (job.companyPicture != null)
                // Align(
                //   alignment: Alignment.centerLeft,
                // child:
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10))),
                  child: ClipRRect(
                    borderRadius:
                        const BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                    child: Image.network(
                      "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/company-logo-design-template-e089327a5c476ce5c70c74f7359c5898_screen.jpg?ts=1672291305", //job.companyPicture!,
                      height: 75,
                      // width: 200,
                    ),
                  ),
                ),
                // ),
                const SizedBox(width: 10),

                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            sizedBoxSmall,
                            Text(
                              job.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 18, color: white, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              job.companyName.isEmpty ? 'اسم الشركة' : job.companyName,
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: white, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const Spacer(),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child:
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                        // Color(0xffFFD099),
                        // Color(0xffFF9209),
                        // Color(0xffFF6C22),
                        // Color.fromARGB(255, 255, 99, 21),
                        Color.fromARGB(255, 124, 145, 250),

                        blue
                        // Color.fromARGB(255, 246, 112, 208),
                        // Color.fromARGB(255, 156, 27, 225),
                        // Color(0xff615EFC),
                      ]),
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                  child: Text(
                    job.jobType,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: gray, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const GradientIcon(
                          offset: Offset(0, 0),
                          gradient: LinearGradient(colors: [
                            Color(0xffFFD099),
                            Color(0xffFF9209),
                            Color(0xffFF6C22),
                          ]),
                          icon: Icons.location_pin,
                          size: 19),
                      const SizedBox(width: 2),
                      Padding(
                          padding: const EdgeInsets.only(top: 0.0),
                          child: Text(
                            job.location,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: white, fontWeight: FontWeight.w600),
                          )),
                      const Spacer(),
                      const GradientIcon(
                          offset: Offset(0, 0),
                          gradient: LinearGradient(colors: [
                            Color(0xffFFD099),
                            Color(0xffFF9209),
                            Color(0xffFF6C22),
                          ]),
                          icon: Icons.category,
                          size: 19),
                      const SizedBox(width: 2),
                      Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            job.location,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: white, fontWeight: FontWeight.w600),
                          )),
                      const SizedBox(width: 2),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          job.category.name,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) => const RadialGradient(
                          center: Alignment.centerRight,
                          radius: 5.0,
                          tileMode: TileMode.clamp,
                          colors: [
                            Color(0xffFFD099),
                            Color(0xffFF9209),
                            Color(0xffFF6C22),
                          ],
                        ).createShader(bounds),
                        child: Text(
                          '${context.loc.experienceLevel}: ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: white, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          job.experienceLevel,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: white, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) => const RadialGradient(
                          center: Alignment.centerRight,
                          radius: 2,
                          tileMode: TileMode.clamp,
                          colors: [
                            Color(0xffFFD099),
                            Color(0xffFF9209),
                            Color(0xffFF6C22),
                          ],
                        ).createShader(bounds),
                        child: Text(
                          '${context.loc.salary}: ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: white, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          job.salary.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: gray, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) => const RadialGradient(
                          center: Alignment.centerRight,
                          radius: 4.5,
                          tileMode: TileMode.clamp,
                          colors: [
                            // Color(0xffFFD099),
                            // Color(0xffFF9209),
                            // Color(0xffFF6C22),

                            Color(0xffD1D8C5),
                            Color(0xff7E8EF1),
                            Color(0xff615EFC),
                          ],
                        ).createShader(bounds),
                        child: Text(
                          '${context.loc.applicationDeadline}: ',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: gray, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          job.applicationDeadline?.substring(0, 10) ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: gray, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
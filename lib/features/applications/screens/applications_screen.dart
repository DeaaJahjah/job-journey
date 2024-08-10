import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/chat_button.dart';
import 'package:job_journey/core/config/widgets/custom_progress.dart';
import 'package:job_journey/core/config/widgets/elevated_button_custom.dart';
import 'package:job_journey/features/applications/providers/applications_provider.dart';
import 'package:job_journey/features/applications/widgets/application_details_widget.dart';
import 'package:job_journey/features/chat/chat_provider.dart';
import 'package:provider/provider.dart';
import 'package:show_up_animation/show_up_animation.dart';

class ApplicationsScreen extends StatefulWidget {
  static const routeName = '/applications-screen';
  const ApplicationsScreen({super.key});

  @override
  State<ApplicationsScreen> createState() => _ApplicationsScreenState();
}

class _ApplicationsScreenState extends State<ApplicationsScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final jobId = ModalRoute.of(context)!.settings.arguments as String;
      context.read<ApplicationsProvider>().listenToApplications(jobId: jobId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        elevation: 0,
        title: Text(context.loc.applications),
      ),
      body: Consumer<ApplicationsProvider>(
        builder: (context, proivder, child) {
          if (proivder.dataState == DataState.loading) {
            return const Center(
              child: CustomProgress(),
            );
          }
          if (proivder.dataState == DataState.failure) {
            return Center(
              child: Text(
                context.loc.errorHappendWhileFetchingData,
                style: largTextStyle,
              ),
            );
          }
          return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: proivder.applications.length,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) {
                final application = proivder.applications[index];
                return ShowUpAnimation(
                  animationDuration: const Duration(milliseconds: 250),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(color: brown, borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Text(
                          application.name,
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white),
                        ),
                        sizedBoxSmall,
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  application.profilePicture == null ? null : NetworkImage(application.profilePicture!),
                              radius: 22,
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "${context.loc.address}: ",
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white),
                                      ),
                                      Expanded(
                                        child: Text(
                                          application.location,
                                          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${context.loc.phoneNumber}: ",
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white),
                                      ),
                                      Text(
                                        application.phoneNumber,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${context.loc.email}: ",
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white),
                                      ),
                                      Text(
                                        application.email,
                                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  sizedBoxSmall,
                                  Text(
                                    context.loc.personalSummary,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white),
                                  ),
                                  Text(
                                    application.summary,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        sizedBoxLarge,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            children: [
                              Consumer<ChatProvider>(builder: (_, provider, child) {
                                return const ChatButton();
                              }),
                              const SizedBox(width: 5),
                              Expanded(
                                child: ElevatedButtonCustom(
                                  onPressed: () {
                                    showModalBottomSheet(
                                        useSafeArea: true,
                                        isScrollControlled: true,
                                        constraints: BoxConstraints(
                                            maxHeight: MediaQuery.sizeOf(context).height * .85,
                                            minWidth: MediaQuery.sizeOf(context).width),
                                        backgroundColor: brown,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
                                        context: context,
                                        builder: (context) {
                                          return ApplicationDetailsBottomSheet(application: application);
                                        });
                                  },
                                  text: context.loc.showDetails,
                                  textColor: white,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}

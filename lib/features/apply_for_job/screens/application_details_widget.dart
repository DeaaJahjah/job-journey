import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/core/config/extensions/firebase.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/custom_progress.dart';
import 'package:job_journey/core/config/widgets/custom_snackbar.dart';
import 'package:job_journey/features/apply_for_job/providers/apply_provider.dart';
import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';
import 'package:provider/provider.dart';

class ApplicationDetailsBottomSheet extends StatelessWidget {
  const ApplicationDetailsBottomSheet({super.key, required this.application, required this.jobId});

  final JobSeekerModel application;
  final String jobId;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(color: const Color(0xff2E2D2D), borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  application.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white),
                ),
                sizedBoxMedium,
                Row(
                  children: [
                    Text(
                      "${context.loc.address}: ",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white),
                    ),
                    Expanded(
                      child: Text(
                        application.location,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "${context.loc.email}: ",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white),
                    ),
                    Text(
                      application.email,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                sizedBoxSmall,
                Text(
                  context.loc.personalSummary,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white),
                ),
                Text(
                  application.summary,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
                sizedBoxSmall,
                Text(
                  context.loc.skills,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: application.skills?.length ?? 0,
                  itemBuilder: (context, index) => Text(
                    application.skills?[index] ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ),
                sizedBoxSmall,
                Text(
                  context.loc.softSkills,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: application.softSkills?.length ?? 0,
                  itemBuilder: (context, index) => Text(
                    application.softSkills?[index] ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ),
                sizedBoxSmall,
                Text(
                  context.loc.certificates,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: application.certificates?.length ?? 0,
                  itemBuilder: (context, index) => Text(
                    application.certificates?[index] ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ),
                sizedBoxSmall,
                Text(
                  context.loc.languages,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: application.languages?.length ?? 0,
                  itemBuilder: (context, index) => Text(
                    application.languages?[index] ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  ),
                ),
                sizedBoxMedium,
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Consumer<ApplayProvider>(builder: (context, provider, child) {
                return provider.dataState != DataState.loading
                    ? InkWell(
                        onTap: () async {
                          await provider.sendApplication(
                              applicationInfo: application.copyWith(id: context.firebaseUser!.uid), jobId: jobId);

                          if (provider.dataState == DataState.failure) {
                            showErrorSnackBar(context, context.loc.errorSendingResume);
                            return;
                          }
                          showSuccessSnackBar(context, context.loc.resumeSentSuccessfully);
                        },
                        child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(begin: Alignment.centerLeft, colors: [lightpurple, purple]),
                            ),
                            child: const Icon(
                              Icons.outgoing_mail,
                              color: white,
                              size: 20,
                            )),
                      )
                    : const CustomProgress();
              }),
              sizedBoxMedium,
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: application.toJson().toString()));
                  showSuccessSnackBar(context, context.loc.resumeCopied);
                },
                child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(begin: Alignment.centerLeft, colors: [lightBlue, blue]),
                    ),
                    child: const Icon(
                      Icons.copy,
                      color: white,
                      size: 20,
                    )),
              ),
              sizedBoxMedium,
            ],
          ),
        )
      ],
    );
  }
}

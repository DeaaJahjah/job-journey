import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/core/config/extensions/firebase.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/custom_progress.dart';
import 'package:job_journey/core/config/widgets/custom_snackbar.dart';
import 'package:job_journey/core/config/widgets/elevated_button_custom.dart';
import 'package:job_journey/features/apply_for_job/gemini.dart';
import 'package:job_journey/features/apply_for_job/providers/apply_provider.dart';
import 'package:job_journey/features/company/models/job_model.dart';
import 'package:job_journey/features/job_seeker/providers/job_seeker_provider.dart';
import 'package:provider/provider.dart';

class SelectApplyTypeScreen extends StatelessWidget {
  final JobModel? job;
  static const String routeName = '/select-apply-type';

  const SelectApplyTypeScreen({super.key, this.job});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: white,
        title: Text(context.loc.applyForJob),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/cv.png',
            height: 300,
          ),
          sizedBoxMedium,
          Text(
            context.loc.applyMessage,
            textAlign: TextAlign.center,
            style: meduimTextStyle,
          ),
          sizedBoxLarge,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * .2),
            child: Consumer<ApplayProvider>(builder: (context, provider, child) {
              return provider.dataState != DataState.loading
                  ? ElevatedButtonCustom(
                      onPressed: () async {
                        await provider.sendApplication(
                            applicationInfo: context
                                .read<JobSeekerProvider>()
                                .jobSeekerModel!
                                .copyWith(id: context.firebaseUser!.uid, createdAt: DateTime.now().toIso8601String()),
                            jobId: job!.id);

                        if (provider.dataState == DataState.failure) {
                          showErrorSnackBar(context, context.loc.errorSendingResume);
                          return;
                        }
                        showSuccessSnackBar(context, context.loc.resumeSentSuccessfully);
                        // Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectApplyTypeScreen(job: ,),));
                      },
                      text: context.loc.sendYourProfile,
                      textColor: white,
                    )
                  : const CustomProgress();
            }),
          ),
          sizedBoxLarge,
          Text(
            context.loc.or,
            textAlign: TextAlign.center,
            style: meduimTextStyle,
          ),
          sizedBoxLarge,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.sizeOf(context).width * .1),
            child: ElevatedButtonCustom(
              blueGradientButton: false,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => GeminiCvMaker(
                    job: job,
                  ),
                ));
                // Navigator.of(context).pushNamed(SelectApplyTypeScreen.routeName,arguments: );
              },
              text: context.loc.generateCv,
              textColor: white,
            ),
          ),
        ],
      ),
    );
  }
}

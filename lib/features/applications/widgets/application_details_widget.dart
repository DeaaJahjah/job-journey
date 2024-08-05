import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/elevated_button_custom.dart';
import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';

class ApplicationDetailsBottomSheet extends StatelessWidget {
  const ApplicationDetailsBottomSheet({
    super.key,
    required this.application,
  });

  final JobSeekerModel application;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: ElevatedButtonCustom(
                showIcon: true,
                textColor: white,
                blueGradientButton: false,
                onPressed: () {},
                text: context.loc.downloadPdf),
          ),
        ],
      ),
    );
  }
}

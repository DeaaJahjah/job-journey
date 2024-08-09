import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';

class ProfileBodyWithOutShimer extends StatelessWidget {
  const ProfileBodyWithOutShimer({
    super.key,
    required this.profile,
  });

  final JobSeekerModel profile;

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
            profile.summary,
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
                        Expanded(
                          child: Text(
                            profile.skills?[index] ?? '',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: white, letterSpacing: 1),
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
    );
  }
}

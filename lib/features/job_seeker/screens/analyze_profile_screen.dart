import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/custom_dialog.dart';
import 'package:job_journey/features/job_seeker/models/profile_analysis_resualt_model.dart';

class AnalyzeProfileScreen extends StatefulWidget {
  static const routeName = '/analyze-profile-screen';

  final String? data;
  const AnalyzeProfileScreen({super.key, this.data});

  @override
  State<AnalyzeProfileScreen> createState() => _AnalyzeProfileScreenState();
}

class _AnalyzeProfileScreenState extends State<AnalyzeProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // if(widget.data!.contains('```json')){
    //   widget.data.replaceAll(from, replace)
    // }
    ProfileAnalysisResualt analysisResualt = ProfileAnalysisResualt.fromJson(json.decode(widget.data!));

    return Scaffold(
        appBar: AppBar(
          title: const Text('تحليل الملف الشخصي'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(8.0),
          children: [
            Container(
                height: 100,
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  gradient: const LinearGradient(begin: Alignment.centerLeft, colors: [lightpurple, purple]),
                ),
                child: Text(
                  '${analysisResualt.generalRating}/10',
                  style: largTextStyle.copyWith(color: white, fontSize: 26),
                )).animate().scale().fadeIn(),
            sizedBoxMedium,
            const Align(
              alignment: Alignment.center,
              child: Text(
                'التقييم الكلي لملفك الشخصي',
                style: largTextStyle,
              ),
            ),
            sizedBoxLarge,
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'التحسينات',
                style: largTextStyle,
              ),
            ),
            sizedBoxLarge,
            ImprovmentSectionCard(
              sectionName: context.loc.personalSummary,
              icon: Icons.description,
              rating: analysisResualt.summaryRating,
            ),
            ImprovmentSectionCard(
              sectionName: context.loc.skills,
              icon: Icons.star_border_purple500_outlined,
              rating: analysisResualt.skillsRating,
            ),
            ImprovmentSectionCard(
              sectionName: context.loc.softSkills,
              icon: Icons.data_saver_off_outlined,
              rating: analysisResualt.softSkillsRating,
            ),
            ImprovmentSectionCard(
              sectionName: context.loc.certificates,
              icon: Icons.card_giftcard_outlined,
              rating: analysisResualt.certificatesRating,
            ),
            ImprovmentSectionCard(
              sectionName: context.loc.languages,
              icon: Icons.language_outlined,
              rating: analysisResualt.languagesRating,
            )
          ],
        ));
  }
}

class ImprovmentSectionCard extends StatelessWidget {
  const ImprovmentSectionCard({super.key, required this.rating, required this.icon, required this.sectionName});
  final Rating? rating;
  final String sectionName;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return rating == null
        ? sizedBoxSmall
        : Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            decoration: BoxDecoration(color: brown, borderRadius: BorderRadius.circular(10)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(begin: Alignment.centerLeft, colors: [lightpurple, purple]),
                    ),
                    child: Icon(
                      icon,
                      color: white,
                      size: 30,
                    )),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      sectionName,
                      style: meduimTextStyle,
                    ),
                    sizedBoxSmall,
                    rating!.improvements!.isEmpty
                        ? const Text(
                            'لا يوجد اقتراحات',
                            style: smallTextStyle,
                          )
                        : GestureDetector(
                            onTap: () {
                              CustomDialogs(context).showbottomSheetDialog(
                                  widget: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                  color: brown,
                                ),
                                child: Column(
                                  children: [
                                    sizedBoxSmall,
                                    Text(
                                      sectionName,
                                      style: largTextStyle,
                                    ),
                                    sizedBoxMedium,
                                    const Divider(
                                      color: Colors.grey,
                                      endIndent: 20,
                                      indent: 20,
                                      thickness: .5,
                                    ),
                                    sizedBoxSmall,

                                    const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'نصائح',
                                          style: largTextStyle,
                                        )),
                                    sizedBoxSmall,
                                    ...rating!.improvements!.map((e) => Row(
                                          children: [
                                            Container(
                                              height: 8,
                                              width: 8,
                                              decoration:
                                                  const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                e,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(color: white, letterSpacing: 1),
                                              ),
                                            ),
                                          ],
                                        )),
                                    sizedBoxSmall,

                                    const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                          'الشكل النهائي',
                                          style: largTextStyle,
                                        )),
                                    sizedBoxSmall,

                                    ...rating!.suggestions!.map((e) => Row(
                                          children: [
                                            Container(
                                              height: 8,
                                              width: 8,
                                              decoration:
                                                  const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                e,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge
                                                    ?.copyWith(color: white, letterSpacing: 1),
                                              ),
                                            ),
                                          ],
                                        )),
                                    // Padding(
                                    //     padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 3),
                                    //     child: Flexible(
                                    //       child: ListView.builder(
                                    //           shrinkWrap: true,
                                    //           physics: const NeverScrollableScrollPhysics(),
                                    //           itemCount: rating.improvements.length,
                                    //           itemBuilder: (context, index) => sizedBoxMedium),
                                    //     )),
                                  ],
                                ),
                              ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                borderRadius: BorderRadius.circular(50),
                                gradient:
                                    const LinearGradient(begin: Alignment.centerLeft, colors: [lightpurple, purple]),
                              ),
                              child: const Text(
                                'عرض الاقتراحات',
                                style: smallTextStyle,
                              ),
                            ),
                          ),
                  ],
                ),
                const Spacer(),
                Text(
                  '${rating!.rating}/10',
                  style: smallTextStyle,
                ),
              ],
            ).animate().fade().slideX(),
          );
  }
}

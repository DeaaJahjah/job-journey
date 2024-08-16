import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gradient_icon/gradient_icon.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/core/config/extensions/firebase.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/chat_button.dart';
import 'package:job_journey/core/config/widgets/custom_snackbar.dart';
import 'package:job_journey/core/config/widgets/elevated_button_custom.dart';
import 'package:job_journey/core/config/widgets/loading_dialog.dart';
import 'package:job_journey/core/utils/shared_pref.dart';
import 'package:job_journey/features/applications/screens/applications_screen.dart';
import 'package:job_journey/features/apply_for_job/screens/select_apply_type_screen.dart';
import 'package:job_journey/features/company/models/job_model.dart';
import 'package:job_journey/features/company/providers/company_provider.dart';
import 'package:job_journey/features/company/screens/add_job_screen.dart';
import 'package:provider/provider.dart';

class JobDetailsScreen extends StatefulWidget {
  static const routeName = '/job-details-screen';
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  final ScrollController controller = ScrollController();
  final _pinned = true;
  final _snap = false;
  final _floating = false;
  @override
  Widget build(BuildContext context) {
    JobModel job = context.watch<CompanyProvider>().jobDetails!;
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
        controller: controller,
        slivers: <Widget>[
          SliverAppBar(
            actions: [
              if (context.isCompanyAccount)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PopupMenuButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: const Icon(Icons.settings),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.edit,
                              color: background,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              context.loc.edit,
                              style: smallTextStyle.copyWith(color: background, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        onTap: () async {
                          Navigator.of(context).pushNamed(AddJobScreen.routeName, arguments: job);
                        },
                      ),
                      PopupMenuItem(
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete,
                              color: background,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              context.loc.delete,
                              style: smallTextStyle.copyWith(color: background, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        onTap: () {
                          final provider = context.read<CompanyProvider>();
                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  surfaceTintColor: gray,
                                  backgroundColor: darkGray,
                                  // icon:
                                  title: Row(
                                    children: [
                                      const Icon(Icons.error_outline_outlined),
                                      const SizedBox(width: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Text(context.loc.confirm, style: largTextStyle),
                                      ),
                                    ],
                                  ),
                                  content: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(context.loc.areYouSureToDeleteTheJob, style: largTextStyle),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        Navigator.of(context).pop();
                                        showLoadingDialog(context);
                                        await provider.deleteJob(job.id).then((_) {
                                          if (provider.dataState == DataState.failure) {
                                            Navigator.of(context).pop();
                                            showErrorSnackBar(context, context.loc.somethingWentWrong);
                                            return;
                                          }
                                          Navigator.of(context).pop();
                                          Navigator.of(context).pop();
                                          showSuccessSnackBar(context, context.loc.jobDeletedSuccessfully);
                                        });
                                      },
                                      child: Text(context.loc.delete, style: meduimTextStyle),
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(),
                                      child: Text(context.loc.cancel, style: meduimTextStyle),
                                    )
                                  ],
                                );
                              });
                        },
                      )
                    ],
                  ),
                ),
            ],
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 160.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      job.title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 18, color: white, fontWeight: FontWeight.bold),
                      // ),
                    ),
                  ],
                ),
              ),
              background: Hero(
                tag: job.id,
                child: job.companyPicture != null || job.companyPicture == 'company'
                    ? Stack(
                        children: [
                          Positioned.fill(
                            child: CachedNetworkImage(
                              imageUrl: job.companyPicture!,
                              cacheKey: job.companyPicture,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned.fill(
                            child: Container(
                              color: Colors.black38,
                            ),
                          )
                        ],
                      )
                    : Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://marketplace.canva.com/EAFK6GIdp20/1/0/1600w/canva-blue-%26-black-simple-company-logo-nwGjVuSJ-D0.jpg"),
                                fit: BoxFit.cover)),
                        child: Container(
                          color: Colors.black54,
                        ),
                      ),
              ),
              centerTitle: true,
            ),
            centerTitle: true,
            // automaticallyImplyLeading: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                sizedBoxSmall,
                Center(
                  child: Text(
                    job.companyName.isEmpty ? 'شركة فيليكس للتكنولوجيا' : job.companyName,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const GradientIcon(
                      icon: Icons.location_pin,
                      offset: Offset.zero,
                      size: 19,
                      gradient: LinearGradient(colors: [lightBlue, blue]),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Text(
                        job.location,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                sizedBoxSmall,
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconTextContainer(
                            title: context.loc.jobType,
                            text: job.jobType,
                            icon: Icons.work_rounded,
                          ),
                          const SizedBox(width: 25),
                          IconTextContainer(
                            title: context.loc.salary,
                            text: job.salary.toString(),
                            icon: Icons.monetization_on,
                          ),
                        ],
                      ),
                      sizedBoxSmall,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconTextContainer(
                            title: context.loc.experienceLevel,
                            text: job.experienceLevel,
                            icon: Icons.stacked_bar_chart,
                          ),
                          const SizedBox(width: 25),
                          IconTextContainer(
                            title: context.loc.applicationDeadline,
                            text: job.applicationDeadline?.substring(0, 10) ?? '',
                            icon: Icons.access_time_filled_rounded,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconTextContainer(
                            title: context.loc.category,
                            text: SharedPreferencesManager().isArabic() ? job.category.name : job.category.enName,
                            icon: Icons.category,
                          ),
                        ],
                      ),
                      TitleBodyText(title: context.loc.description, text: job.description),
                      sizedBoxMedium,
                      TitleBodyText(title: context.loc.additionalInfo, text: job.additionalInfo ?? ''),
                      sizedBoxMedium,
                      TitleListWidget(title: context.loc.requirements, list: job.requirements),
                      sizedBoxMedium,
                      TitleListWidget(title: context.loc.requiredDocuments, list: job.requiredDocuments),
                      sizedBoxMedium,
                      TitleListWidget(title: context.loc.benefits, list: job.benefits ?? []),
                      sizedBoxMedium,
                      // if (!context.isCompanyAccount)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: [
                            if (!context.isCompanyAccount) ...[
                              ChatButton(
                                userId: job.companyId,
                                userName: job.companyName,
                              ),
                              const SizedBox(width: 10)
                            ],
                            Expanded(
                              child: ElevatedButtonCustom(
                                onPressed: () {
                                  context.isCompanyAccount
                                      ? Navigator.of(context).pushNamed(ApplicationsScreen.routeName, arguments: job.id)
                                      : Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => SelectApplyTypeScreen(
                                            job: job,
                                          ),
                                        ));
                                },
                                text: context.isCompanyAccount ? context.loc.applications : context.loc.applyForJob,
                                textColor: white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ])),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class IconTextContainer extends StatelessWidget {
  const IconTextContainer({
    super.key,
    // required this.job,
    required this.text,
    required this.title,
    required this.icon,
  });
  final String text;
  final String title;
  final IconData icon;
  // final JobModel job;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: SharedPreferencesManager().isArabic() ? 150 : 180),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: .5,
          color: Colors.grey,
        ),
        color: background,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          textDirection: TextDirection.ltr,
          children: [
            Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(shape: BoxShape.circle, color: gray.withOpacity(.1)),
                child: GradientIcon(
                    offset: const Offset(0, 0),
                    gradient: const LinearGradient(colors: [lightBlue, blue]),
                    icon: icon,
                    size: 19)),
            const SizedBox(width: 10),
            Column(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 2),
                ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) => const RadialGradient(
                          center: Alignment.centerRight,
                          radius: 5.0,
                          tileMode: TileMode.clamp,
                          colors: [lightBlue, blue],
                        ).createShader(bounds),
                    child: Text(
                      text,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: blue, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TitleBodyText extends StatelessWidget {
  final String title;
  final String text;

  const TitleBodyText({super.key, required this.title, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) => const RadialGradient(
                  center: Alignment.centerRight,
                  radius: 2,
                  tileMode: TileMode.clamp,
                  colors: [lightBlue, blue],
                ).createShader(bounds),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: blue, fontWeight: FontWeight.bold),
            )),
        const SizedBox(height: 5),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey,
              ),
        ),
      ],
    );
  }
}

class TitleListWidget extends StatelessWidget {
  final String title;
  final List<String> list;
  const TitleListWidget({super.key, required this.title, required this.list});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
            blendMode: BlendMode.srcIn,
            shaderCallback: (Rect bounds) => const RadialGradient(
                  center: Alignment.centerRight,
                  radius: 5.0,
                  tileMode: TileMode.clamp,
                  colors: [lightBlue, blue],
                ).createShader(bounds),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
            )),
        const SizedBox(height: 5),
        ListView.builder(
          shrinkWrap: true,
          itemCount: list.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Row(
            children: [
              Container(
                height: 8,
                width: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [lightBlue, blue],
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  list[index],
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

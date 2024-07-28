import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/custom_progress.dart';
import 'package:job_journey/features/company/providers/company_provider.dart';
import 'package:provider/provider.dart';

class JobDetailsScreen extends StatefulWidget {
  static const routeName = '/job-details-screen';
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      final jobId = ModalRoute.of(context)!.settings.arguments as String;
      context.read<CompanyProvider>().getJobDetails(jobId: jobId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: SafeArea(
        child: Consumer<CompanyProvider>(
          builder: (context, provider, _) {
            if (provider.dataState == DataState.loading) {
              return const CustomProgress();
            }
            if (provider.dataState == DataState.failure) {
              return const Center(child: Text('حدث خطأ ما أثناء جلب البيانات'));
            }
            if (provider.jobDetails == null) {
              return const Center(child: Text('لا يوجد بيانات'));
            }
            final job = provider.jobDetails!;
            return ListView(
              padding: const EdgeInsets.all(8),
              children: [
                Container(
                  height: 100,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                        "https://d1csarkz8obe9u.cloudfront.net/posterpreviews/company-logo-design-template-e089327a5c476ce5c70c74f7359c5898_screen.jpg?ts=1672291305", //job.companyPicture!,
                      ))),
                ),
                sizedBoxSmall,
                Center(
                  child: Text(
                    job.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 24, color: white, fontWeight: FontWeight.bold),
                  ),
                ),
                // const SizedBox(height: 5),
                Center(
                  child: Text(
                    job.category.name,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white, fontWeight: FontWeight.bold),
                  ),
                ),
                sizedBoxMedium,
                Text(
                  context.loc.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  job.description,
                  style:
                      Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                sizedBoxMedium,
                Text(
                  context.loc.additionalInfo,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  job.additionalInfo ?? '',
                  style:
                      Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                sizedBoxMedium,

                Text(
                  context.loc.requirements,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: job.requirements.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Row(
                    children: [
                      Text(
                        '⚪',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: 9),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          job.requirements[index],
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBoxMedium,
                Text(
                  context.loc.requiredDocuments,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: job.requiredDocuments.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Row(
                    children: [
                      Text(
                        '⚪',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: 9),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          job.requiredDocuments[index],
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBoxMedium,
                Text(
                  context.loc.benefits,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: job.benefits?.length ?? 0,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Row(
                    children: [
                      Text(
                        '⚪',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey, fontSize: 9),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          job.benefits![index],
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
                sizedBoxMedium,
                Text(
                  context.loc.salary,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  job.salary.toString(),
                  style:
                      Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                sizedBoxMedium,
              ],
            );
          },
        ),
      ),
    );
  }
}

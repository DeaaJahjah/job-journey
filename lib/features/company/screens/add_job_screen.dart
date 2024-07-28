import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/core/config/extensions/firebase.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/custom_progress.dart';
import 'package:job_journey/core/config/widgets/custom_snackbar.dart';
import 'package:job_journey/core/config/widgets/drop_down_custom.dart';
import 'package:job_journey/core/config/widgets/elevated_button_custom.dart';
import 'package:job_journey/core/config/widgets/text_field_custome.dart';
import 'package:job_journey/features/company/models/category.dart';
import 'package:job_journey/features/company/models/job_model.dart';
import 'package:job_journey/features/company/providers/benfits_provider.dart';
import 'package:job_journey/features/company/providers/company_provider.dart';
import 'package:job_journey/features/company/providers/required_documents_provider.dart';
import 'package:job_journey/features/company/providers/requirements_provider.dart';
import 'package:job_journey/features/company/screens/benefits_widget.dart';
import 'package:job_journey/features/company/screens/required_documents_widget.dart';
import 'package:job_journey/features/company/screens/requirements_widget.dart';
import 'package:provider/provider.dart';

class AddJobScreen extends StatefulWidget {
  static const routeName = '/add-job-screen';
  const AddJobScreen({super.key});

  @override
  State<AddJobScreen> createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController requirementsController = TextEditingController();
  TextEditingController documentsController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController salaryController = TextEditingController();
  TextEditingController additionalInfoController = TextEditingController();
  TextEditingController benefitsController = TextEditingController();
  TextEditingController deadLineController = TextEditingController();
  String? selectedType;
  String? selectedCity;
  Category? selectedCategory;

  List<TextEditingController> requirements = [TextEditingController()];
  final _formKey = GlobalKey<FormState>();

  @override
  void deactivate() {
    context.read<RequirementsProvider>().clearRequirements();
    context.read<RequiredDocumentsProvider>().clearDocuments();
    context.read<BenefitsProvider>().clearBenefits();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: white,
        title: Text(context.loc.addJob),
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              TextFieldCustom(
                text: context.loc.jobTitle,
                controller: titleController,
              ),
              sizedBoxSmall,
              DropDownCustom(
                hint: context.loc.category,
                categories: categories.map((e) => e.name).toList(), // jobTypes,
                selectedItem: selectedCategory?.name,
                onChanged: (item) {
                  setState(() {
                    selectedCategory = categories.getCategory(item!);
                  });
                },
              ),
              sizedBoxSmall,
              DropDownCustom(
                hint: context.loc.jobType,
                categories: jobTypes,
                selectedItem: selectedType,
                onChanged: (item) {
                  setState(() {
                    selectedType = item;
                  });
                },
              ),
              sizedBoxSmall,
              DropDownCustom(
                hint: context.loc.location,
                categories: cities,
                selectedItem: selectedCity,
                onChanged: (item) {
                  setState(() {
                    selectedCity = item;
                  });
                },
              ),
              sizedBoxSmall,
              Text(context.loc.requirements,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: gray)),
              const SizedBox(height: 5),
              const RequirementsWidget(),
              sizedBoxSmall,
              Text(context.loc.requiredDocuments,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: gray)),
              const SizedBox(height: 5),
              const RequiredDocumentsWidget(),
              sizedBoxSmall,
              TextFieldCustom(
                text: context.loc.experienceLevel,
                controller: experienceController,
              ),
              sizedBoxSmall,
              TextFieldCustom(
                text: context.loc.salary,
                controller: salaryController,
                keyboardType: TextInputType.number,
              ),
              sizedBoxSmall,
              TextFieldCustom(
                text: context.loc.description,
                controller: descriptionController,
                maxLine: null,
                keyboardType: TextInputType.multiline,
              ),
              sizedBoxSmall,
              TextFieldCustom(
                text: context.loc.additionalInfo,
                controller: additionalInfoController,
                validate: false,
                maxLine: null,
              ),
              sizedBoxSmall,
              Text(context.loc.benefits,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold, color: gray)),
              const SizedBox(height: 5),
              const BenefitsWidget(),
              sizedBoxSmall,
              TextFieldCustom(
                onTap: () async {
                  final date =
                      await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2030));
                  if (date != null) deadLineController.text = date.toIso8601String();
                },
                text: context.loc.applicationDeadline,
                controller: deadLineController,
                readOnly: true,
              ),
              sizedBoxMedium,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Consumer<CompanyProvider>(
                  builder: (_, provider, __) => provider.dataState == DataState.loading
                      ? const CustomProgress()
                      : ElevatedButtonCustom(
                          color: blue,
                          textColor: white,
                          text: context.loc.add,
                          onPressed: () async {
                            final isValid = _formKey.currentState?.validate() ?? false;
                            if (isValid && selectedCategory != null && selectedCity != null && selectedType != null) {
                              final JobModel job = JobModel(
                                  id: '',
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  location: selectedCity!,
                                  category: selectedCategory!,
                                  jobType: selectedType!,
                                  requirements:
                                      context.read<RequirementsProvider>().requirements.map((req) => req.text).toList(),
                                  requiredDocuments: context
                                      .read<RequiredDocumentsProvider>()
                                      .documents
                                      .map((doc) => doc.text)
                                      .toList(),
                                  experienceLevel: experienceController.text,
                                  additionalInfo: additionalInfoController.text,
                                  applicationDeadline: deadLineController.text,
                                  benefits: context.read<BenefitsProvider>().benefits.map((ben) => ben.text).toList(),
                                  companyPicture: context.firebaseUser?.photoURL,
                                  salary: double.parse(salaryController.text),
                                  companyId: context.userUid!,
                                  companyName: context.firebaseUser!.displayName!);
                              provider.addJob(job).then((_) {
                                if (provider.dataState == DataState.failure) {
                                  showErrorSnackBar(context, 'حدث خطأ ما');
                                  return;
                                }
                                showSuccessSnackBar(context, 'تمت إضافة الوظيفة بنجاح');
                                Navigator.of(context).pop();
                              });
                            } else {
                              showErrorSnackBar(context, 'بعض الحقول مطلوبة يرجى التحقق منها');
                            }
                          },
                        ),
                ),
              ),
            ],
          )),
    );
  }
}

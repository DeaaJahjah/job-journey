import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/firebase.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/custom_snackbar.dart';
import 'package:job_journey/core/config/widgets/drop_down_custom.dart';
import 'package:job_journey/core/config/widgets/elevated_button_custom.dart';
import 'package:job_journey/core/config/widgets/text_field_custome.dart';
import 'package:job_journey/core/services/file_services.dart';
import 'package:job_journey/core/utils/shared_pref.dart';
import 'package:job_journey/features/company/models/category.dart';
import 'package:job_journey/features/company/models/company_model.dart';
import 'package:job_journey/features/company/providers/company_provider.dart';
import 'package:job_journey/features/company/providers/create_update_company_provider.dart';
import 'package:job_journey/features/job_seeker/providers/job_seeker_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class EditCompanyProfileScreen extends StatefulWidget {
  static const String routeName = '/edit-company-profile-screen';
  const EditCompanyProfileScreen({super.key});

  @override
  State<EditCompanyProfileScreen> createState() => _EditCompanyProfileScreenState();
}

class _EditCompanyProfileScreenState extends State<EditCompanyProfileScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController foundingDate = TextEditingController();
  TextEditingController industry = TextEditingController();
  TextEditingController description = TextEditingController();

  Category? selectedIndustry;

  XFile? pickedimage;
  String fileName = '';
  File? imageFile;
  String? imageUrl;
  var formKey = GlobalKey<FormState>();
  bool isLoading = false;
  _pickImage() async {
    final picker = ImagePicker();
    try {
      pickedimage = await picker.pickImage(source: ImageSource.gallery);
      fileName = path.basename(pickedimage!.path);
      imageFile = File(pickedimage!.path);

      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    final company = context.read<CompanyProvider>().profile!;
    userName = TextEditingController(text: company.name);
    email = TextEditingController(text: company.email);
    passwordController = TextEditingController(text: company.password);
    location = TextEditingController(text: company.location);
    phoneController = TextEditingController(text: company.phoneNumber);
    foundingDate = TextEditingController(text: company.foundingDate);
    description = TextEditingController(text: company.description);
    imageUrl = company.profilePicture;
    selectedIndustry = company.industry;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(context.loc.editProfile, style: appBarTextStyle),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: Column(children: [
              sizedBoxLarge,
              InkWell(
                  onTap: () {
                    _pickImage();
                    setState(() {});
                  },
                  child: (pickedimage == null)
                      ? imageUrl == null
                          ? Container(
                              decoration: BoxDecoration(color: gray, borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(25),
                              child: Image.asset(
                                'assets/images/select_img.png',
                                width: 75,
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(color: gray, borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(20),
                              child: Image.network(imageUrl!))
                      : Container(
                          decoration: BoxDecoration(color: gray, borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(20),
                          child: Image.file(imageFile!))),
              const SizedBox(
                height: 20,
              ),
              TextFieldCustom(text: context.loc.name, controller: userName, icon: Icons.person),
              const SizedBox(
                height: 20,
              ),
              TextFieldCustom(text: context.loc.email, controller: email, icon: Icons.email),
              const SizedBox(
                height: 20,
              ),
              TextFieldCustom(text: context.loc.password, controller: passwordController, icon: Icons.lock),
              const SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        context.loc.phoneNumber,
                        style: const TextStyle(fontWeight: FontWeight.w800, color: white),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        margin: const EdgeInsets.only(left: 5),
                        decoration: BoxDecoration(color: blue, borderRadius: BorderRadius.circular(10)),
                        child: const Text('+963', style: TextStyle(fontWeight: FontWeight.w800)),
                      )),
                      Expanded(
                        flex: 4,
                        child: TextFieldCustom(
                            text: context.loc.phoneNumber,
                            controller: phoneController,
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              DropDownCustom(
                hint: context.loc.location,
                icon: Icons.location_on,
                categories: cities,
                selectedItem: location.text,
                onChanged: (item) {
                  setState(() {
                    location.text = item ?? '';
                  });
                },
              ),
              // TextFieldCustom(text: context.loc.location, controller: location, icon: Icons.location_on),
              const SizedBox(
                height: 20,
              ),
              TextFieldCustom(
                text: context.loc.description,
                controller: description,
                icon: Icons.description,
                keyboardType: TextInputType.multiline,
                maxLine: null,
              ),
              const SizedBox(
                height: 20,
              ),
              sizedBoxSmall,
              DropDownCustom(
                hint: context.loc.industry,
                icon: Icons.business_center_rounded,
                categories: industries.map((e) => SharedPreferencesManager().isArabic() ? e.name : e.enName).toList(),
                selectedItem: SharedPreferencesManager().isArabic() ? selectedIndustry?.name : selectedIndustry?.enName,
                onChanged: (item) {
                  setState(() {
                    selectedIndustry = industries.getCategory(item!);
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldCustom(
                onTap: () async {
                  final date =
                      await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(2030));
                  if (date != null) foundingDate.text = date.toIso8601String();
                },
                readOnly: true,
                text: context.loc.foundingDate,
                controller: foundingDate,
                icon: Icons.date_range,
                keyboardType: TextInputType.datetime,
                maxLine: 1,
              ),
              const SizedBox(
                height: 24,
              ),
              !isLoading
                  ? ElevatedButtonCustom(
                      textColor: white,
                      onPressed: () async {
                        if (formKey.currentState!.validate() && selectedIndustry != null) {
                          if (imageUrl == null && imageFile == null) {
                            var snackBar = const SnackBar(content: Text('الرجاء اخيار صورة'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            return;
                          }

                          //TODO:: login by firebase

                          setState(() {
                            isLoading = true;
                          });
                          final comProvider = context.read<CreateUpdateCompanyProvider>();

                          // final re = await FlutterFireAuthServices()
                          //     .(email: email.text, password: passwordController.text, context: context);
                          try {
                            await context.firebaseUser?.updatePassword(passwordController.text);
                            await context.firebaseUser!.verifyBeforeUpdateEmail(email.text);
                            await context.firebaseUser!.updateDisplayName(userName.text);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'requires-recent-login') {
                              setState(() {
                                isLoading = false;
                              });
                              showErrorSnackBar(
                                  context,
                                  SharedPreferencesManager().isArabic()
                                      ? "تحديث الملف الشخصي يحتاج تسجيل دخول حديث \n يرجى إعادة تسجيل الدخل قبل القيام بهذه العملية."
                                      : "This operation needs a recent-login please log out and login again to complete updating your profile.");
                            }
                            print('auth exception' + e.message.toString());
                            return;
                          }
                          //set user type
                          context.firebaseUser!.updatePhotoURL('company');

                          String? resultUrl;

                          if (imageFile != null) {
                            imageUrl = await FileDbService().uploadeimage(fileName, imageFile!, context);
                          }

                          //TODO:: create company
                          await comProvider.updateCompany(
                              company: CompanyModel(
                                  id: context.firebaseUser!.uid,
                                  name: userName.text,
                                  phoneNumber: phoneController.text,
                                  profilePicture: resultUrl ?? imageUrl,
                                  email: email.text,
                                  password: passwordController.text,
                                  industry: selectedIndustry!,
                                  location: location.text,
                                  description: description.text,
                                  foundingDate: foundingDate.text));
                          setState(() {
                            isLoading = false;
                          });

                          if (context.firebaseUser!.photoURL != 'company') {
                            await context.read<JobSeekerProvider>().getJobSeeker(userId: context.firebaseUser!.uid);
                          } else {
                            await context.read<CompanyProvider>().getCompanyProfile(userId: context.firebaseUser!.uid);
                          }
                          Navigator.of(context).pop();
                        } else {
                          var snackBar = SnackBar(content: Text(context.loc.allFieldsRequired));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      text: context.loc.save,
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                      color: blue,
                    )),
              sizedBoxLarge
            ]),
          ),
        ),
      ),
    );
  }
}

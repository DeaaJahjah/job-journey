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
import 'package:job_journey/features/company/providers/company_provider.dart';
import 'package:job_journey/features/job_seeker/models/job_seeker_model.dart';
import 'package:job_journey/features/job_seeker/providers/job_seeker_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class EditJobSeekerProfileScreen extends StatefulWidget {
  static const String routeName = '/edit-job-seeker-profile-screen';
  const EditJobSeekerProfileScreen({super.key});

  @override
  State<EditJobSeekerProfileScreen> createState() => _EditJobSeekerProfileScreenState();
}

class _EditJobSeekerProfileScreenState extends State<EditJobSeekerProfileScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController location = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController description = TextEditingController();

  TextEditingController certificates = TextEditingController();
  TextEditingController languages = TextEditingController();
  TextEditingController skills = TextEditingController();
  TextEditingController softSkills = TextEditingController();
  List<Category> topicsSubscription = [];
  String? selectedCity;
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
    final jobSeeker = context.read<JobSeekerProvider>().jobSeekerModel!;
    userName = TextEditingController(text: jobSeeker.name);
    email = TextEditingController(text: jobSeeker.email);
    passwordController = TextEditingController(text: jobSeeker.password);
    location = TextEditingController(text: jobSeeker.location);
    phoneController = TextEditingController(text: jobSeeker.phoneNumber);
    description = TextEditingController(text: jobSeeker.summary);
    certificates = TextEditingController(text: jobSeeker.certificates?.join());
    languages = TextEditingController(text: jobSeeker.languages?.join());
    skills = TextEditingController(text: jobSeeker.skills?.join());
    softSkills = TextEditingController(text: jobSeeker.softSkills?.join());
    imageUrl = jobSeeker.profilePicture;
    topicsSubscription = jobSeeker.topicsSubscription ?? [];
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
                categories: cities,
                selectedItem: location.text,
                onChanged: (item) {
                  setState(() {
                    location.text = item ?? '';
                  });
                },
                icon: Icons.location_pin,
              ),
              // TextFieldCustom(text: context.loc.location, controller: location, icon: Icons.location_on),
              const SizedBox(
                height: 20,
              ),
              Text(context.loc.professionalInformation),
              TextFieldCustom(
                text: context.loc.aboutYou,
                controller: description,
                icon: Icons.description,
                keyboardType: TextInputType.multiline,
                maxLine: null,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFieldCustom(
                text: context.loc.certificates,
                controller: certificates,
                icon: Icons.receipt,
                keyboardType: TextInputType.multiline,
                maxLine: null,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldCustom(
                text: context.loc.skills,
                controller: skills,
                icon: Icons.bolt_rounded,
                keyboardType: TextInputType.multiline,
                maxLine: null,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldCustom(
                text: context.loc.softSkills,
                controller: softSkills,
                icon: Icons.workspaces_outline,
                keyboardType: TextInputType.multiline,
                maxLine: null,
              ),
              const SizedBox(
                height: 24,
              ),
              TextFieldCustom(
                text: context.loc.languages,
                controller: languages,
                icon: Icons.language,
                keyboardType: TextInputType.multiline,
                maxLine: null,
              ),
              const SizedBox(
                height: 24,
              ),
              !isLoading
                  ? ElevatedButtonCustom(
                      textColor: white,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (imageFile == null && imageUrl == null) {
                            var snackBar = SnackBar(
                                content: Text(SharedPreferencesManager().isArabic()
                                    ? 'الرجاء اخيار صورة'
                                    : "Please select a image"));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            return;
                          }

                          //TODO:: login by firebase

                          setState(() {
                            isLoading = true;
                          });
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

                          context.firebaseUser!.updateDisplayName(userName.text);

                          //set user type
                          context.firebaseUser!.updatePhotoURL('jobSeeker');

                          String? resultUrl;

                          if (imageFile != null) {
                            resultUrl = await FileDbService().uploadeimage(fileName, imageFile!, context);
                            context.firebaseUser!.updatePhotoURL(imageUrl);
                          }

                          await context.read<JobSeekerProvider>().updateJobSeeker(
                              user: JobSeekerModel(
                                  id: context.firebaseUser!.uid,
                                  name: userName.text,
                                  phoneNumber: phoneController.text,
                                  email: email.text,
                                  password: passwordController.text,
                                  location: location.text,
                                  summary: description.text,
                                  profilePicture: resultUrl ?? imageUrl,
                                  certificates: certificates.text.split('-'),
                                  languages: languages.text.split('-'),
                                  skills: skills.text.split('-'),
                                  softSkills: softSkills.text.split('-'),
                                  topicsSubscription: topicsSubscription));
                          setState(() {
                            isLoading = false;
                          });
                          if (context.firebaseUser!.photoURL != 'company') {
                            context.read<JobSeekerProvider>().getJobSeeker(userId: context.firebaseUser!.uid);
                          } else {
                            context.read<CompanyProvider>().getCompanyProfile(userId: context.firebaseUser!.uid);
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

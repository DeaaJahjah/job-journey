import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/firebase.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/core/config/widgets/drop_down_custom.dart';
import 'package:job_journey/core/config/widgets/elevated_button_custom.dart';
import 'package:job_journey/core/config/widgets/text_field_custome.dart';
import 'package:job_journey/core/services/file_services.dart';
import 'package:job_journey/core/utils/shared_pref.dart';
import 'package:job_journey/features/auth/Services/authentecation_service.dart';
import 'package:job_journey/features/chat/providers/video_call_provider.dart';
import 'package:job_journey/features/company/models/category.dart';
import 'package:job_journey/features/company/models/company_model.dart';
import 'package:job_journey/features/company/providers/company_provider.dart';
import 'package:job_journey/features/company/providers/create_update_company_provider.dart';
import 'package:job_journey/features/job_seeker/providers/job_seeker_provider.dart';
import 'package:job_journey/home_screen.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class ComapnySignUpScreen extends StatefulWidget {
  static const String routeName = '/sign-up';
  const ComapnySignUpScreen({super.key});

  @override
  State<ComapnySignUpScreen> createState() => _ComapnySignUpScreenState();
}

class _ComapnySignUpScreenState extends State<ComapnySignUpScreen> {
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
  Widget build(BuildContext context) {
    // isLoading = false;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(context.loc.createCompany, style: appBarTextStyle),
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
              TextFieldCustom(text: context.loc.location, controller: location, icon: Icons.location_on),
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
                categories: industries
                    .map((e) => SharedPreferencesManager().isArabic() ? e.name : e.enName)
                    .toList(), // jobTypes,
                selectedItem: selectedIndustry?.name,
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
                          if (imageFile == null) {
                            var snackBar = const SnackBar(content: Text('الرجاء اخيار صورة'));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            return;
                          }

                          //TODO:: login by firebase

                          setState(() {
                            isLoading = true;
                          });
                          final comProvider = context.read<CreateUpdateCompanyProvider>();

                          final re = await FlutterFireAuthServices()
                              .signUp(email: email.text, password: passwordController.text, context: context);

                          if (re == null) {
                            setState(() {
                              isLoading = false;
                            });
                            return;
                          }

                          context.firebaseUser!.updateDisplayName(userName.text);

                          //set user type
                          context.firebaseUser!.updatePhotoURL('company');

                          String? imageUrl;

                          if (imageFile != null) {
                            imageUrl = await FileDbService().uploadeimage(fileName, imageFile!, context);
                          }

                          await FirebaseChatCore.instance.createUserInFirestore(
                            types.User(
                              firstName: userName.text,
                              id: re.user!.uid,
                              lastName: '',
                            ),
                          );

                          //TODO:: create company
                          await comProvider.createCompany(
                              company: CompanyModel(
                                  id: context.firebaseUser!.uid,
                                  name: userName.text,
                                  phoneNumber: phoneController.text,
                                  profilePicture: imageUrl,
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
                          context.read<VideoCallProvider>().getAgoraSetup();

                          Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
                        } else {
                          var snackBar = SnackBar(content: Text(context.loc.allFieldsRequired));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      text: context.loc.create,
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

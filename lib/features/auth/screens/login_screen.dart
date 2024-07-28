import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/widgets/custom_progress.dart';
import 'package:job_journey/core/config/widgets/custom_snackbar.dart';
import 'package:job_journey/core/config/widgets/elevated_button_custom.dart';
import 'package:job_journey/core/config/widgets/text_field_custome.dart';
import 'package:job_journey/features/auth/Services/authentecation_service.dart';
import 'package:job_journey/features/auth/screens/sign_up_screen.dart';
import 'package:job_journey/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordcontroller = TextEditingController();

  bool isLoading = false;

  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              sizedBoxLarge,
              sizedBoxLarge,
              Image.asset(
                'assets/images/logo-with-text.png',
                height: MediaQuery.sizeOf(context).height * 0.25,
              ),
              sizedBoxLarge,
              Card(
                color: onbackground,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextFieldCustom(
                          keyboardType: TextInputType.emailAddress,
                          text: 'البريد الالكتروني',
                          controller: emailController),
                      sizedBoxMedium,
                      TextFieldCustom(
                          keyboardType: TextInputType.text, text: 'كلمة المرور', controller: passwordcontroller),
                      sizedBoxLarge,
                      isLoading
                          ? const CustomProgress()
                          : ElevatedButtonCustom(
                              color: blue,
                              textColor: white,
                              text: 'تسجيل دخول',
                              onPressed: () async {
                                if (emailController.text.isEmpty || passwordcontroller.text.isEmpty) {
                                  showErrorSnackBar(context, 'يجب عليك ادخال البريد الالكتروني وكلمة السر');

                                  return;
                                }
                                if (!emailController.text.contains('@')) {
                                  showErrorSnackBar(context, 'يجب ادخال بريد الكتروني صالح');

                                  return;
                                }

                                setState(() {
                                  isLoading = true;
                                });

                                setState(() {});
                                final result = await FlutterFireAuthServices().signIn(
                                    email: emailController.text, password: passwordcontroller.text, context: context);

                                print(result);
                                setState(() {
                                  isLoading = true;
                                });
                                if (result != null) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
                                }
                              }),
                      const SizedBox(height: 80),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'ليس لديك حساب؟',
                            style: TextStyle(color: white, fontSize: 16, fontFamily: font),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          TextButton(
                            child: const Text('انضم الينا',
                                style: TextStyle(
                                    color: blue, fontSize: 16, fontFamily: font, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              Navigator.of(context).pushNamed(SignUpScreen.routeName);
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
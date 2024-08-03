import 'package:flutter/material.dart';
import 'package:job_journey/features/auth/screens/comapny_sign_up_screen.dart';
import 'package:job_journey/features/auth/screens/login_screen.dart';
import 'package:job_journey/features/auth/screens/selecte_account_type_screen.dart';
import 'package:job_journey/features/company/screens/add_job_screen.dart';
import 'package:job_journey/features/company/screens/company_profile_screen.dart';
import 'package:job_journey/features/company/screens/job_details_screen.dart';
import 'package:job_journey/features/company/screens/job_overview_screen.dart';
import 'package:job_journey/home_screen.dart';
import 'package:job_journey/splash_screen.dart';

// import 'package:lets_buy/features/chat/messages_screen.dart';
// import 'package:lets_buy/features/help/help_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SplashScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const LoginScreen()));
    case ComapnySignUpScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const ComapnySignUpScreen()));
    case JobsOverViewScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const JobsOverViewScreen()));
    case HomeScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const HomeScreen()));
    case AddJobScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const AddJobScreen()));
    case JobDetailsScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const JobDetailsScreen()), settings: settings);

    case CompanyProfileScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const CompanyProfileScreen()), settings: settings);

      
    case SelectAccountTypeScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const SelectAccountTypeScreen()), settings: settings);

  }

  return null;
}

import 'package:flutter/material.dart';
import 'package:job_journey/features/applications/screens/applications_screen.dart';
import 'package:job_journey/features/auth/screens/comapny_sign_up_screen.dart';
import 'package:job_journey/features/auth/screens/login_screen.dart';
import 'package:job_journey/features/auth/screens/selecte_account_type_screen.dart';
import 'package:job_journey/features/company/screens/add_job_screen.dart';
import 'package:job_journey/features/company/screens/company_profile_screen.dart';
import 'package:job_journey/features/company/screens/job_details_screen.dart';
import 'package:job_journey/features/company/screens/job_overview_screen.dart';
import 'package:job_journey/features/job_seeker/screens/job_seeker_profile_screen.dart';
import 'package:job_journey/features/job_seeker/screens/job_seeker_sign_up_screen.dart';
import 'package:job_journey/features/notifications/screens/notifications_screen.dart';
import 'package:job_journey/features/topicsSubscription/screens/topics_subscription_screen.dart';
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

    case NotificationsScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const NotificationsScreen()), settings: settings);

    case ApplicationsScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const ApplicationsScreen()), settings: settings);

    case JobSeekerProfileScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const JobSeekerProfileScreen()), settings: settings);

    case TopicsSubscriptionScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const TopicsSubscriptionScreen()), settings: settings);

    case SelectAccountTypeScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const SelectAccountTypeScreen()), settings: settings);

    case JobSeekerSignUpScreen.routeName:
      return MaterialPageRoute(builder: ((_) => const JobSeekerSignUpScreen()), settings: settings);
  }

  return null;
}

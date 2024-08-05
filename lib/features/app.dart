import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/routes/routes.dart';
import 'package:job_journey/features/applications/providers/applications_provider.dart';
import 'package:job_journey/features/apply_for_job/providers/apply_provider.dart';
import 'package:job_journey/features/chat/chat_provider.dart';
import 'package:job_journey/features/company/providers/benfits_provider.dart';
import 'package:job_journey/features/company/providers/company_provider.dart';
import 'package:job_journey/features/company/providers/create_update_company_provider.dart';
import 'package:job_journey/features/company/providers/required_documents_provider.dart';
import 'package:job_journey/features/company/providers/requirements_provider.dart';
import 'package:job_journey/features/job_seeker/providers/job_seeker_provider.dart';
import 'package:provider/provider.dart';
// import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CompanyProvider>(create: (_) => CompanyProvider()),
        ChangeNotifierProvider<RequirementsProvider>(create: (_) => RequirementsProvider()),
        ChangeNotifierProvider<RequiredDocumentsProvider>(create: (_) => RequiredDocumentsProvider()),
        ChangeNotifierProvider<BenefitsProvider>(create: (_) => BenefitsProvider()),
        ChangeNotifierProvider<CreateUpdateCompanyProvider>(create: (_) => CreateUpdateCompanyProvider()),
        ChangeNotifierProvider<JobSeekerProvider>(create: (_) => JobSeekerProvider()),
        ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
        ChangeNotifierProvider<ApplayProvider>(create: (_) => ApplayProvider()),
        ChangeNotifierProvider<ApplicationsProvider>(create: (_) => ApplicationsProvider()),
      ],
      child: MaterialApp(
        // home: ApplicationsScreen(),
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar'),
        supportedLocales: const [
          Locale("ar", "AE"),
          // Locale("en", "EN"),
        ],
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        // const [
        //   GlobalCupertinoLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        // ],
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: blue,
            scaffoldBackgroundColor: background,
            appBarTheme: const AppBarTheme(
                backgroundColor: background,
                foregroundColor: white,
                centerTitle: true,
                toolbarHeight: 50,
                titleTextStyle: appBarTextStyle),
            fontFamily: font),
        initialRoute: '/',
      ),
    );
  }
}

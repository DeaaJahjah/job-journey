import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/routes/routes.dart';
import 'package:job_journey/features/company/providers/benfits_provider.dart';
import 'package:job_journey/features/company/providers/company_provider.dart';
import 'package:job_journey/features/company/providers/required_documents_provider.dart';
import 'package:job_journey/features/company/providers/requirements_provider.dart';
import 'package:provider/provider.dart';
// import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class App extends StatelessWidget {
  // final StreamChatClient client;
  const App({
    super.key,
    // required this.client,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CompanyProvider>(create: (_) => CompanyProvider()),
        ChangeNotifierProvider<RequirementsProvider>(create: (_) => RequirementsProvider()),
        ChangeNotifierProvider<RequiredDocumentsProvider>(create: (_) => RequiredDocumentsProvider()),
        ChangeNotifierProvider<BenefitsProvider>(create: (_) => BenefitsProvider()),
      ],
      child: MaterialApp(
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar'),
        supportedLocales: const [
          Locale("ar", "AE"),
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
            appBarTheme:
                const AppBarTheme(backgroundColor: background, centerTitle: true, titleTextStyle: appBarTextStyle),
            fontFamily: font),
        initialRoute: '/',
      ),
    );
  }
}

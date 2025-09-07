import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rkm_daily/core/constants/app_constants.dart';
import 'package:rkm_daily/core/di/injection.dart';
import 'package:rkm_daily/core/theme/app_theme.dart';
import 'package:rkm_daily/routes/app_router.dart' as router;

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize dependency injection
  await configureDependencies();


  runApp(const RKMDailyApp());
}

class RKMDailyApp extends StatelessWidget {
  const RKMDailyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English
      ],
      routerConfig: router.AppRouter.router,
    );
  }
}

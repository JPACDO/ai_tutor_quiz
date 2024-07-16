import 'package:ai_tutor_quiz/infrastructure/datasources/share_prefs/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ai_tutor_quiz/config/routes/app_router.dart';
import 'package:ai_tutor_quiz/config/themes/app_theme.dart';
import 'package:ai_tutor_quiz/presentation/providers/providers.dart';
import 'package:ai_tutor_quiz/infrastructure/services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //////////CRASHLYTICS
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  //////////PRFERENCES
  final prefs = UserPreferences();
  await prefs.initPrefs();

  /////////REMOTE CONFIG
  final remoteConfigService = FirebaseRemoteConfigService();
  await remoteConfigService.initialize();

  //////////DETECTAR VERSION DEL APP
  await AppVersionPackageInfo().initialize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);

    final appRouter = ref.watch(appRouterProvider);
    final seedColor = ref.watch(colorThemeProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'AI Tutor Quiz',
      routerConfig: appRouter,
      theme: AppTheme(isDarkmode: isDarkMode, seedColor: seedColor).getTheme(),
    );
  }
}

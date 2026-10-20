import 'package:flutter/material.dart';
import 'core/config/env_config.dart';
import 'core/theme/app_theme.dart';
import 'ui/features/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables (.env) securely before starting the app
  await EnvConfig.initialize();

  runApp(const ParleyApp());
}

/// Root widget configuring theme and initial routing.
class ParleyApp extends StatelessWidget {
  const ParleyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: EnvConfig.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
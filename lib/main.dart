import 'package:flutter/material.dart';
import 'core/config/env_config.dart';
import 'core/theme/app_theme.dart';
import 'ui/features/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Carrega as variáveis de ambiente (.env) de forma segura antes da execução da aplicação
  await EnvConfig.initialize();

  runApp(const ParleyApp());
}

/// Widget raiz da aplicação configurando tema global e tela inicial.
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
import 'package:flutter_test/flutter_test.dart';
import 'package:parley_app/core/config/env_config.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Testes de EnvConfig', () {
    test('Valores de fallback são seguros e íntegros após inicialização do EnvConfig', () async {
      await EnvConfig.initialize();

      expect(EnvConfig.appName, isNotEmpty);
      expect(EnvConfig.speechListenTimeoutSeconds, isPositive);
      expect(EnvConfig.speechPauseSeconds, isPositive);
      expect(EnvConfig.defaultSourceLocale, equals('pt_BR'));
      expect(EnvConfig.defaultTargetLocale, equals('en_US'));
    });
  });
}

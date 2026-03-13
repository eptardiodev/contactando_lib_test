import 'dart:async';

import 'package:contactando_app_gs/configuration/app_logger.dart';
import 'package:contactando_app_gs/configuration/environment.dart';
import 'package:contactando_app_gs/configuration/local_storage.dart';
import 'package:contactando_app_gs/configuration/supabase_config.dart';
import 'package:contactando_app_gs/configuration/supabase_initializer.dart';
import 'package:contactando_app_gs/routes/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';

/// IMPORTANT!! run this command to generate build files:
/// dart run build_runner build --delete-conflicting-outputs
/// flutter pub run intl_utils:generate
///
/// Main entry point — PRODUCTION environment.
///
/// Para pasar credenciales de producción sin hardcodear:
///   flutter build apk \
///     --dart-define=SUPABASE_URL=https://tu-proyecto.supabase.co \
///     --dart-define=SUPABASE_ANON_KEY=eyJ...
void main() {
  runZonedGuarded(_bootstrap, _onError);
}

Future<void> _bootstrap() async {
  AppLogger.configure(isProduction: true);
  final log = AppLogger.getLogger('main_prod.dart');

  ProfileConstants.setEnvironment(Environment.prod);
  SupabaseConfig.setEnvironment(SupabaseEnvironment.prod);

  log.info('Starting App with env: {}', [Environment.prod.name]);

  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Supabase antes de cualquier otra cosa
  await SupabaseInitializer.initialize();

  const defaultLanguage = 'en';
  AppLocalStorage().setStorage(StorageType.sharedPreferences);
  await AppLocalStorage().save(StorageKeys.language.name, defaultLanguage);

  AppRouter().setRouter(RouterType.goRouter);

  const defaultThemeName = 'dark';
  await AppLocalStorage().save(StorageKeys.theme.name, defaultThemeName);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  log.info(
    'Started App — language: {}, theme: {}',
    [defaultLanguage, defaultThemeName],
  );

  runApp(const App(language: defaultLanguage));
}

void _onError(Object error, StackTrace stack) {
  final log = AppLogger.getLogger('main_prod.dart');
  log.error('Unhandled error: {} \n{}', [error.toString(), stack.toString()]);
}

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
/// Main entry point — LOCAL / DEVELOPMENT environment.
void main() {
  runZonedGuarded(_bootstrap, _onError);
}

Future<void> _bootstrap() async {
  AppLogger.configure(isProduction: false);
  final log = AppLogger.getLogger('main_local.dart');

  ProfileConstants.setEnvironment(Environment.dev);
  SupabaseConfig.setEnvironment(SupabaseEnvironment.dev);

  log.info('Starting App with env: {}', [Environment.dev.name]);

  WidgetsFlutterBinding.ensureInitialized();

  // Inicializar Supabase antes de cualquier otra cosa
  await SupabaseInitializer.initialize();

  const defaultLanguage = 'en';
  AppLocalStorage().setStorage(StorageType.sharedPreferences);
  await AppLocalStorage().save(StorageKeys.language.name, defaultLanguage);

  AppRouter().setRouter(RouterType.goRouter);

  const defaultThemeName = 'system';
  await AppLocalStorage().save(StorageKeys.theme.name, defaultThemeName);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  log.info(
    'Started App — language: {}, theme: {}',
    [defaultLanguage, defaultThemeName],
  );

  runApp(const App(language: defaultLanguage));
}

void _onError(Object error, StackTrace stack) {
  final log = AppLogger.getLogger('main_local.dart');
  log.error('Unhandled error: {} \n{}', [error.toString(), stack.toString()]);
}

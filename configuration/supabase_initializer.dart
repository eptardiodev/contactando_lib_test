import 'package:contactando_app_gs/configuration/app_logger.dart';
import 'package:contactando_app_gs/configuration/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Servicio encargado de inicializar Supabase.
///
/// Se llama una única vez desde cada `main_*.dart` antes de [runApp].
/// Separar esta lógica del main mantiene cada archivo con una sola
/// responsabilidad y facilita mockear Supabase en tests.
class SupabaseInitializer {
  static final _log = AppLogger.getLogger('SupabaseInitializer');

  SupabaseInitializer._();

  /// Inicializa Supabase con las credenciales del ambiente activo.
  ///
  /// Lanza una excepción si la inicialización falla, para que el error
  /// sea visible desde el inicio y no silenciado en runtime.
  static Future<void> initialize() async {
    _log.info(
      'Initializing Supabase with url: {}',
      [SupabaseConfig.url],
    );

    await Supabase.initialize(
      url: SupabaseConfig.url,
      anonKey: SupabaseConfig.anonKey,
      // Podés habilitar debug solo en dev:
      // debug: ProfileConstants.isDevelopment,
    );

    _log.info('Supabase initialized successfully');
  }
}

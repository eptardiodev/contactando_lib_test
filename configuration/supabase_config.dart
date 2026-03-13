/// Configuración de Supabase por ambiente.
///
/// Las credenciales se centralizan aquí y se consumen desde
/// [SupabaseConfig.url] y [SupabaseConfig.anonKey] en los mains.
///
/// ⚠️  SEGURIDAD:
/// - La anonKey de Supabase es pública por diseño (se usa en clientes).
///   La seguridad real se configura en Row Level Security (RLS) en Supabase.
/// - Nunca expongas la service_role key en el cliente.
/// - En CI/CD usá variables de entorno y String.fromEnvironment en lugar
///   de hardcodear las keys de producción.
class SupabaseConfig {
  SupabaseConfig._();

  static String get url => _current[_Keys.url]!;
  static String get anonKey => _current[_Keys.anonKey]!;

  static Map<String, String> _current = _Credentials.dev;

  static void setEnvironment(SupabaseEnvironment env) {
    switch (env) {
      case SupabaseEnvironment.dev:
        _current = _Credentials.dev;
        break;
      case SupabaseEnvironment.prod:
        _current = _Credentials.prod;
        break;
    }
  }
}

enum SupabaseEnvironment { dev, prod }

class _Keys {
  static const url = 'url';
  static const anonKey = 'anonKey';
}

class _Credentials {
  /// Credenciales de desarrollo / staging.
  static const Map<String, String> dev = {
    _Keys.url: 'https://wrjlrhngdjifdntwqecb.supabase.co',
    _Keys.anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndyamxyaG5nZGppZmRudHdxZWNiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgzMjY2NDUsImV4cCI6MjA3MzkwMjY0NX0.uRPHQbz9MPiKDiOGc1AcsoBAUUgC3rgoVZ6NjtbVY3Q',
  };

  /// Credenciales de producción.
  /// TODO: reemplazá estos valores con los de tu proyecto Supabase de producción.
  /// Recomendación: usá --dart-define en el pipeline de CI/CD:
  ///   flutter run --dart-define=SUPABASE_URL=... --dart-define=SUPABASE_KEY=...
  static const Map<String, String> prod = {
    _Keys.url: String.fromEnvironment(
      'SUPABASE_URL',
      defaultValue: 'https://xasuustrxjurgntqexvs.supabase.co',
    ),
    _Keys.anonKey: String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue:
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9'
          '.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inhhc3V1c3RyeGp1cmdudHFleHZzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ2ODUyOTAsImV4cCI6MjA3MDI2MTI5MH0'
          '.eh9dZEdfvSeMpe77CVjdUOkEIIQ4KYvumSUHBLDkvSc',
    ),
  };
}

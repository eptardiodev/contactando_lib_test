import 'package:contactando_app_gs/configuration/local_storage.dart';
import 'package:flutter/foundation.dart';

/// Global notifier to trigger UI rebuilds on language changes without altering app architecture.
class LanguageNotifier {
  LanguageNotifier._();

  /// Current language code notifier (e.g., 'en', 'tr').
  static final ValueNotifier<String> current = ValueNotifier<String>(AppLocalStorageCached.language ?? 'en');
}

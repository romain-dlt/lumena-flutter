import 'package:flutter/widgets.dart';
import 'package:lumena_ai/l10n/app_localizations.dart';

/// Extension pour accéder facilement aux localisations via context.t
extension LocalizationExtension on BuildContext {
  /// Raccourci pour accéder aux traductions
  /// Usage: context.t.helloWorld
  AppLocalizations get t => AppLocalizations.of(this)!;
}

import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class RatingService {
  static const String _lastShownKey = 'rating_dialog_last_shown';
  static const int _minIntervalDays = 7;
  static const double _showProbability = 0.3; // 30% de chance d'afficher

  /// Vérifie si le dialogue de notation peut être affiché
  /// Retourne true si au moins une semaine s'est écoulée depuis la dernière fois
  static Future<bool> canShowRatingDialog() async {
    final prefs = await SharedPreferences.getInstance();
    final lastShown = prefs.getInt(_lastShownKey);

    // Si jamais affiché, on peut l'afficher (avec probabilité)
    if (lastShown == null) {
      return _shouldShowRandomly();
    }

    // Calcule le temps écoulé en jours
    final now = DateTime.now().millisecondsSinceEpoch;
    final daysSinceLastShown = (now - lastShown) / (1000 * 60 * 60 * 24);

    // Vérifie si l'intervalle minimum est respecté
    if (daysSinceLastShown >= _minIntervalDays) {
      return _shouldShowRandomly();
    }

    return false;
  }

  /// Enregistre que le dialogue a été affiché
  static Future<void> markDialogShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastShownKey, DateTime.now().millisecondsSinceEpoch);
  }

  /// Détermine aléatoirement si le dialogue doit être affiché
  /// (pour ne pas l'afficher systématiquement)
  static bool _shouldShowRandomly() {
    return Random().nextDouble() < _showProbability;
  }
}

/// Service pour synchroniser les animations across all widgets
/// en utilisant un temps absolu plutôt que des controllers individuels
class AnimationSyncService {
  static final AnimationSyncService _instance =
      AnimationSyncService._internal();
  factory AnimationSyncService() => _instance;
  AnimationSyncService._internal();

  /// Durée totale d'un cycle d'animation en millisecondes
  static const int cycleDuration = 4000;

  /// Retourne la progression actuelle de l'animation (0.0 à 1.0)
  /// basée sur le temps absolu depuis le démarrage de l'app
  double getCurrentProgress() {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final progress = (currentTime % cycleDuration) / cycleDuration;
    return progress;
  }

  /// Calcule la position de la barre lumineuse basée sur le temps absolu
  /// Retourne une valeur entre -0.1 et 1.1 avec des pauses
  double getLightBarPosition() {
    final progress = getCurrentProgress();

    // TweenSequence breakdown:
    // 0.0 - 0.2 (20%): Animation de -0.1 à 1.1 (descente)
    // 0.2 - 0.5 (30%): Pause à 1.1
    // 0.5 - 0.7 (20%): Animation de 1.1 à -0.1 (remontée)
    // 0.7 - 1.0 (30%): Pause à -0.1

    if (progress < 0.2) {
      // Descente: -0.1 à 1.1
      final localProgress = progress / 0.2;
      return _easeInOut(-0.1 + (localProgress * 1.2));
    } else if (progress < 0.5) {
      // Pause en bas
      return 1.1;
    } else if (progress < 0.7) {
      // Remontée: 1.1 à -0.1
      final localProgress = (progress - 0.5) / 0.2;
      return _easeInOut(1.1 - (localProgress * 1.2));
    } else {
      // Pause en haut
      return -0.1;
    }
  }

  /// Applique une courbe easeInOut
  double _easeInOut(double t) {
    if (t < -0.1) return -0.1;
    if (t > 1.1) return 1.1;

    // Normaliser entre 0 et 1 pour appliquer la courbe
    final normalized = (t + 0.1) / 1.2;
    final curved = normalized < 0.5
        ? 2 * normalized * normalized
        : 1 - 2 * (1 - normalized) * (1 - normalized);

    // Revenir à l'échelle -0.1 à 1.1
    return -0.1 + (curved * 1.2);
  }
}

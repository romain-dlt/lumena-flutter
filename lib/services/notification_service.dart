import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static const String _freeTrialNotificationKey =
      'free_trial_notification_scheduled';

  /// Initialise le service de notifications
  static Future<void> initialize() async {
    // Initialiser les fuseaux horaires
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(initSettings);
  }

  /// Demande les permissions de notification (iOS)
  static Future<bool> requestPermissions() async {
    final result = await _notifications
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    return result ?? true; // Android n'a pas besoin de permissions explicites
  }

  /// Planifie une notification pour le free trial qui expire dans 24h
  /// La notification sera envoyée 48h après l'achat (72h - 24h)
  static Future<void> scheduleFreeTrialExpirationNotification({
    required String title,
    required String body,
  }) async {
    try {
      // Vérifier si une notification est déjà planifiée
      final prefs = await SharedPreferences.getInstance();
      final alreadyScheduled =
          prefs.getBool(_freeTrialNotificationKey) ?? false;

      if (alreadyScheduled) {
        print('Free trial notification already scheduled');
        return;
      }

      // Demander les permissions
      await requestPermissions();

      // Calculer le moment de la notification (48h à partir de maintenant)
      final scheduledDate = tz.TZDateTime.now(
        tz.local,
      ).add(const Duration(hours: 48));

      const androidDetails = AndroidNotificationDetails(
        'free_trial_channel',
        'Free Trial Notifications',
        channelDescription: 'Notifications about free trial expiration',
        importance: Importance.high,
        priority: Priority.high,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      // Planifier la notification
      await _notifications.zonedSchedule(
        0, // ID de notification unique
        title,
        body,
        scheduledDate,
        notificationDetails,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

      // Marquer la notification comme planifiée
      await prefs.setBool(_freeTrialNotificationKey, true);

      print('Free trial notification scheduled for: $scheduledDate');
    } catch (e) {
      print('Error scheduling free trial notification: $e');
    }
  }

  /// Annule la notification de free trial
  static Future<void> cancelFreeTrialNotification() async {
    try {
      await _notifications.cancel(0);

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_freeTrialNotificationKey);

      print('Free trial notification cancelled');
    } catch (e) {
      print('Error cancelling free trial notification: $e');
    }
  }

  /// Annule toutes les notifications
  static Future<void> cancelAllNotifications() async {
    try {
      await _notifications.cancelAll();

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_freeTrialNotificationKey);
    } catch (e) {
      print('Error cancelling all notifications: $e');
    }
  }
}

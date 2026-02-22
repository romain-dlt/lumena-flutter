import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:lumena_ai/services/notification_service.dart';

const String _kProEntitlementKey = 'Lumena PRO';

class IAPService {
  static Future<void> initializeRevenueCat() async {
    String apiKey = dotenv.env['REVENUECAT_API_KEY'] ?? '';

    await Purchases.configure(PurchasesConfiguration(apiKey));

    // Enable debug logs (à désactiver en production si nécessaire)
    await Purchases.setLogLevel(LogLevel.debug);
  }

  /// Lie RevenueCat à l'utilisateur Supabase
  static Future<void> loginUser(String userId) async {
    try {
      await Purchases.logIn(userId);
    } catch (e) {
      print('Error logging in to RevenueCat: $e');
      rethrow;
    }
  }

  /// Déconnecte l'utilisateur de RevenueCat
  static Future<void> logoutUser() async {
    try {
      await Purchases.logOut();
    } catch (e) {
      print('Error logging out from RevenueCat: $e');
    }
  }

  static Future<bool> isPro() async {
    CustomerInfo customerInfo = await Purchases.getCustomerInfo();

    return customerInfo.entitlements.active.containsKey(_kProEntitlementKey);
  }

  static Future<CustomerInfo> getCustomerInfo() async {
    return await Purchases.getCustomerInfo();
  }

  static Future<void> restorePurchases(
    VoidCallback onSuccess,
    VoidCallback onError,
    VoidCallback onNoPurchases,
  ) async {
    try {
      CustomerInfo customerInfo = await Purchases.restorePurchases();

      if (customerInfo.entitlements.active.containsKey(_kProEntitlementKey)) {
        onSuccess();
      } else {
        onNoPurchases();
      }
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);

      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        onError();
      }
    }
  }

  static Future<Offerings> getOfferings() async {
    try {
      // Sync purchases first to ensure latest data
      await Purchases.syncPurchases();

      final offerings = await Purchases.getOfferings();

      if (offerings.current == null) {
        print('Warning: Current offering is null');
      }

      return offerings;
    } catch (e) {
      print('Error getting offerings: $e');
      rethrow;
    }
  }

  static Future<bool> purchase(
    Package package,
    VoidCallback onError, {
    String? notificationTitle,
    String? notificationBody,
  }) async {
    try {
      final purchaseParams = PurchaseParams.package(package);
      PurchaseResult purchaseResult = await Purchases.purchase(purchaseParams);

      final isProActive = purchaseResult.customerInfo.entitlements.active
          .containsKey(_kProEntitlementKey);

      // Si l'achat est réussi et que le package a un introductory price (free trial)
      if (isProActive && package.storeProduct.introductoryPrice != null) {
        // Planifier la notification 24h avant la fin du free trial
        await NotificationService.scheduleFreeTrialExpirationNotification(
          title: notificationTitle ?? 'Your free trial ends soon!',
          body:
              notificationBody ??
              'Your 3-day free trial will expire in 24 hours. Keep enjoying Lumena PRO!',
        );
      }

      return isProActive;
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);

      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        onError();
      }

      return false;
    }
  }

  static Future<bool> changePlan(
    Package newPackage,
    String currentProductIdentifier,
    VoidCallback onError,
  ) async {
    try {
      final purchaseParams = PurchaseParams.package(
        newPackage,
        googleProductChangeInfo: GoogleProductChangeInfo(
          currentProductIdentifier,
          prorationMode: GoogleProrationMode.immediateWithTimeProration,
        ),
      );
      PurchaseResult purchaseResult = await Purchases.purchase(purchaseParams);

      return purchaseResult.customerInfo.entitlements.active.containsKey(
        _kProEntitlementKey,
      );
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);

      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        onError();
      }

      return false;
    }
  }
}

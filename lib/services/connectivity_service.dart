import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/widgets/widgets.dart';

class ConnectivityService {
  static final Connectivity _connectivity = Connectivity();
  static StreamSubscription<List<ConnectivityResult>>? _subscription;
  static bool _hasShownDialog = false;

  static Future<void> initialize(BuildContext context) async {
    // Vérifier la connectivité initiale
    final result = await _connectivity.checkConnectivity();
    if (!_hasConnection(result) && context.mounted) {
      _showNoConnectionDialog(context);
    }

    // Écouter les changements de connectivité
    _subscription = _connectivity.onConnectivityChanged.listen((
      List<ConnectivityResult> results,
    ) {
      if (!_hasConnection(results)) {
        final context = _getContext();
        if (context != null && context.mounted && !_hasShownDialog) {
          _showNoConnectionDialog(context);
        }
      } else {
        _hasShownDialog = false;
      }
    });
  }

  static bool _hasConnection(List<ConnectivityResult> results) {
    return results.any(
      (result) =>
          result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet,
    );
  }

  static BuildContext? _getContext() {
    // Récupérer le contexte depuis le navigateur global
    return navigatorKey.currentContext;
  }

  static void _showNoConnectionDialog(BuildContext context) {
    if (_hasShownDialog) return;
    _hasShownDialog = true;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => MessageDialog(
        title: context.t.noInternetConnectionTitle,
        description: context.t.noInternetConnectionDescription,
        onOkPress: () {
          SystemNavigator.pop();
        },
      ),
    );
  }

  static void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}

// Global key pour accéder au contexte
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

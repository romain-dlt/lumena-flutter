import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:lumena_ai/services/iap_service.dart';

class AuthService {
  static Session? getSession() {
    final session = Supabase.instance.client.auth.currentSession;
    return session;
  }

  static User? getUser() {
    final user = Supabase.instance.client.auth.currentUser;
    return user;
  }

  static bool isAuthenticated() {
    final session = getSession();
    return session != null;
  }

  static Future<void> signInWithGoogle(BuildContext context) async {
    final webClientId = dotenv.env['GOOGLE_OAUTH_CLIENT_ID'] ?? '';

    final scopes = ['email', 'profile'];
    final googleSignIn = GoogleSignIn.instance;
    await googleSignIn.initialize(serverClientId: webClientId);
    final googleUser = await googleSignIn.authenticate();
    final authorization =
        await googleUser.authorizationClient.authorizationForScopes(scopes) ??
        await googleUser.authorizationClient.authorizeScopes(scopes);
    final idToken = googleUser.authentication.idToken;

    if (idToken == null) {
      throw AuthException('No ID Token found.');
    }

    await Supabase.instance.client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: authorization.accessToken,
    );

    // Lier RevenueCat avec l'ID utilisateur Supabase
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId != null) {
      await IAPService.loginUser(userId);
    }

    if (context.mounted) {
      // Retourner true pour indiquer que la connexion a réussi
      Navigator.of(context).pop();
    }
  }

  static Future<void> signOut(BuildContext context) async {
    try {
      // Déconnecter RevenueCat
      await IAPService.logoutUser();

      await Supabase.instance.client.auth.signOut();
      if (context.mounted) {
        Navigator.of(context).pushReplacementNamed('/');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error signing out: $e')));
      }
    }
  }
}

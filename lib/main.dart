import 'package:flutter/material.dart';
import 'package:lumena_ai/pages/pages.dart';
import 'package:lumena_ai/pages/onboarding/welcome_screen.dart';
import 'package:lumena_ai/services/connectivity_service.dart';
import 'package:lumena_ai/services/iap_service.dart';
import 'package:lumena_ai/services/notification_service.dart';
import 'package:lumena_ai/services/onboarding_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await IAPService.initializeRevenueCat();

  await NotificationService.initialize();

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'] ?? '',
    anonKey: dotenv.env['SUPABASE_ANON_KEY'] ?? '',
  );

  // Si l'utilisateur est déjà connecté, lier RevenueCat à son compte Supabase
  final currentUser = Supabase.instance.client.auth.currentUser;
  if (currentUser != null) {
    await IAPService.loginUser(currentUser.id);
  }

  runApp(const LumenaApp());
}

class LumenaApp extends StatefulWidget {
  const LumenaApp({super.key});

  @override
  State<LumenaApp> createState() => _LumenaAppState();
}

class _LumenaAppState extends State<LumenaApp> {
  @override
  void initState() {
    super.initState();
    // Initialiser le service de connectivité après le premier frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ConnectivityService.initialize(context);
      }
    });
  }

  @override
  void dispose() {
    ConnectivityService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 915),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: 'BricolageGrotesque'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          localeResolutionCallback: (locale, supportedLocales) {
            // Si la langue de l'appareil est supportée, l'utiliser
            if (locale != null) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode) {
                  return supportedLocale;
                }
              }
            }
            // Sinon, fallback à l'anglais
            return const Locale('en');
          },
          home: FutureBuilder<bool>(
            future: OnboardingService.shouldShowOnboarding(),
            builder: (context, snapshot) {
              // Afficher un loader pendant la vérification
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              // Si c'est le premier lancement, afficher l'onboarding
              if (snapshot.data == true) {
                return const WelcomeScreen();
              }

              // Sinon, afficher la page d'accueil
              return const HomePage();
            },
          ),
          routes: {
            '/home': (context) => const HomePage(),
            '/settings': (context) => const SettingsPage(),
            '/edit': (context) => const EditPage(),
            '/sign-in': (context) => const SignInPage(),
            '/premium-hook': (context) => const PremiumHookPage(),
            '/premium-paywall': (context) => const PremiumPaywallPage(),
            '/plan-upgrade': (context) => const PlanUpgradePage(),
          },
        );
      },
    );
  }
}

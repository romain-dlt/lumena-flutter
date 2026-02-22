import 'package:flutter/material.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:lumena_ai/widgets/widgets.dart';
// import 'package:lumena_ai/pages/onboarding/welcome_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Lumena',
        leading: SettingsButton(),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.bug_report, color: Colors.green),
          //   tooltip: 'Debug: Rating Dialog',
          //   onPressed: () {
          //     showDialog(
          //       context: context,
          //       builder: (context) => const RatingDialog(),
          //     );
          //   },
          // ),
          // // Bouton de debug temporaire pour tester l'onboarding
          // IconButton(
          //   icon: Icon(Icons.bug_report, color: Colors.orange),
          //   tooltip: 'Debug: Onboarding',
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          //     );
          //   },
          // ),
          PremiumPillButton(),
        ],
      ),
      backgroundColor: TWColors.slate.shade200,
      body: PromptCategories(),
      floatingActionButton: FloatingEditButton(),
    );
  }
}

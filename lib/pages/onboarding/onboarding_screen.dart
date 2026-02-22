import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/services/services.dart';
import 'package:lumena_ai/widgets/widgets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<OnboardingData> _getPagesData(BuildContext context) {
    return [
      OnboardingData(
        title: context.t.chooseYourPicture,
        imageUrl: 'assets/images/ai-girlfriend-before.png',
      ),
      OnboardingData(
        title: context.t.typeYourEdit,
        imageUrl: 'assets/images/ai-girlfriend-before.png',
      ),
      OnboardingData(
        title: context.t.watchItTurnReal,
        imageUrl: 'assets/images/ai-girlfriend-after.png',
      ),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _getPagesData(context).length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() async {
    // Marquer l'onboarding comme complété
    await OnboardingService.setOnboardingCompleted();

    // Retourner à la page d'accueil (pop all)
    if (mounted) {
      // Si on vient du premier lancement, remplacer tout le stack
      Navigator.of(
        context,
      ).pushNamedAndRemoveUntil('/premium-hook', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Lumena',
        leading: SizedBox(),
        overrideColor: TWColors.slate.shade50,
      ),
      backgroundColor: TWColors.slate.shade50,
      body: SafeArea(
        child: Column(
          children: [
            // PageView pour le swipe
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  // Vérifier que l'index est valide
                  if (index >= 0 && index < _getPagesData(context).length) {
                    setState(() {
                      _currentPage = index;
                    });
                  }
                  // Si on swipe au-delà de la dernière page, terminer l'onboarding
                  else if (index >= _getPagesData(context).length) {
                    _finishOnboarding();
                  }
                },
                itemCount: _getPagesData(context).length,
                itemBuilder: (context, index) {
                  return OnboardingPage(
                    data: _getPagesData(context)[index],
                    pageIndex: index,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  PageIndicator(
                    currentPage: _currentPage,
                    pageCount: _getPagesData(context).length,
                  ),
                  const SizedBox(height: 20),
                  PrimaryButton(
                    label: 'Next',
                    iconPath: 'assets/icons/chevron-right.svg',
                    iconPlacement: 'right',
                    onPressed: _nextPage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String imageUrl;

  OnboardingData({required this.title, required this.imageUrl});
}

class OnboardingPage extends StatefulWidget {
  final OnboardingData data;
  final int pageIndex;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.pageIndex,
  });

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Animation pour la capsule popup (seulement pour la page 2)
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticOut,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    // Déclencher l'animation avec un délai
    if (widget.pageIndex == 1) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          _animationController.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 2),

          // Image avec capsule animée pour la page 2
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(widget.data.imageUrl, width: 300.w),
              ),

              // Capsule animée (seulement pour la page 2)
              if (widget.pageIndex == 1)
                Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: TypewriterCapsule(
                          text: context.t.examplePromptGirlfriend,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),

          const SizedBox(height: 32),
          Text(
            widget.data.title,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}

// Widget capsule avec effet typewriter
class TypewriterCapsule extends StatefulWidget {
  final String text;

  const TypewriterCapsule({super.key, required this.text});

  @override
  State<TypewriterCapsule> createState() => _TypewriterCapsuleState();
}

class _TypewriterCapsuleState extends State<TypewriterCapsule> {
  String _displayedText = '';
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTypewriter();
  }

  void _startTypewriter() {
    Future.delayed(const Duration(milliseconds: 400), () {
      _typeNextCharacter();
    });
  }

  void _typeNextCharacter() {
    if (_currentIndex < widget.text.length) {
      if (mounted) {
        setState(() {
          _displayedText = widget.text.substring(0, _currentIndex + 1);
          _currentIndex++;
        });

        // Délai variable pour rendre l'effet plus naturel
        final delay = widget.text[_currentIndex - 1] == ' ' ? 30 : 50;

        Future.delayed(Duration(milliseconds: delay), () {
          _typeNextCharacter();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: TWColors.slate.shade100.withAlpha(125),
            border: Border.all(color: TWColors.slate.shade300, width: 1.5),
            borderRadius: BorderRadius.circular(999.r),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _displayedText,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: TWColors.slate.shade800,
                ),
              ),
              // Curseur clignotant
              if (_currentIndex < widget.text.length)
                Container(
                  margin: const EdgeInsets.only(left: 2),
                  width: 2,
                  height: 16,
                  color: TWColors.slate.shade900.withAlpha(70),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  const PageIndicator({
    super.key,
    required this.currentPage,
    required this.pageCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pageCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? TWColors.blue.shade600
                : TWColors.slate.shade300,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/utils/rich_text_helper.dart';
import 'package:lumena_ai/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'onboarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.t.welcomeToLumena,
        leading: SizedBox(),
        overrideColor: TWColors.slate.shade50,
      ),
      backgroundColor: TWColors.slate.shade50,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.asset(
                  'assets/images/ai-girlfriend-after.png',
                  width: 300.w,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                context.t.editAnythingWithText,
                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 12.h),
              const Spacer(flex: 3),
              PrimaryButton(
                label: context.t.getStarted,
                iconPath: 'assets/icons/sparks.svg',
                iconPlacement: 'left',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnboardingScreen(),
                    ),
                  );
                },
              ),

              SizedBox(height: 16.h),

              // Notice légale
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: RichTextHelper.parseTextWithLinks(
                    context.t.linkedLegalNotice,
                    baseStyle: TextStyle(
                      color: TWColors.slate.shade500,
                      fontFamily: 'BricolageGrotesque',
                    ),
                    linkStyle: TextStyle(
                      color: TWColors.slate.shade500,
                      fontFamily: 'BricolageGrotesque',
                      decoration: TextDecoration.underline,
                    ),
                    onLinkTap: (linkText) async {
                      if (linkText == context.t.termsOfService) {
                        final Uri uri = Uri.parse(
                          'https://www.trylumena.app/legal/terms',
                        );

                        if (!await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw 'Could not launch $uri';
                        }
                      } else if (linkText == context.t.privacyPolicy) {
                        final Uri uri = Uri.parse(
                          'https://www.trylumena.app/legal/privacy',
                        );

                        if (!await launchUrl(
                          uri,
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw 'Could not launch $uri';
                        }
                      }
                    },
                  ),
                ),
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/services/services.dart';
import 'package:lumena_ai/utils/rich_text_helper.dart';
import 'package:lumena_ai/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _isLoading = false;

  Future<void> _handleSignIn(BuildContext context) async {
    setState(() => _isLoading = true);

    await AuthService.signInWithGoogle(context);

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.t.signIn,
        leading: BackHomeButton(onTap: () => Navigator.of(context).pop()),
        actions: [PremiumPillButton()],
      ),
      backgroundColor: TWColors.slate.shade200,
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20.h,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                'assets/images/ai-girlfriend-after.png',
                width: 300.w,
              ),
            ),
            Text(
              context.t.signInToContinue,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28.sp,
                color: TWColors.slate.shade900,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            PrimaryButton(
              label: context.t.continueWithGoogle,
              iconPath: 'assets/icons/google.svg',
              iconPlacement: 'left',
              onPressed: () => _handleSignIn(context),
              isDisabled: _isLoading,
            ),
            RichText(
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
          ],
        ),
      ),
    );
  }
}

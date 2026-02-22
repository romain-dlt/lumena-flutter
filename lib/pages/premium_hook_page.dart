import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/services/services.dart';
import 'package:lumena_ai/utils/rich_text_helper.dart';
import 'package:lumena_ai/widgets/widgets.dart';

class PremiumHookPage extends StatelessWidget {
  const PremiumHookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PremiumAppBar(),
      backgroundColor: TWColors.blue.shade600,
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _title(context),
              Image.asset(
                'assets/images/premium-home-page-mockup.png',
                width: 300.w,
                fit: BoxFit.contain,
              ),
              PrimaryButton(
                label: context.t.continueButton,
                iconPath: 'assets/icons/chevron-right.svg',
                iconPlacement: 'right',
                onPressed: () => AuthService.isAuthenticated()
                    ? Navigator.pushNamed(context, '/premium-paywall')
                    : Navigator.pushNamed(context, '/sign-in'),
                overrideColor: TWColors.slate.shade50,
                overrideTextColor: TWColors.blue.shade600,
              ),
            ],
          ),
        ),
      ),
    );
  }

  RichText _title(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: RichTextHelper.parseHighlightedText(
        context.t.premiumHookTitle,
        baseStyle: TextStyle(
          color: TWColors.slate.shade50,
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'BricolageGrotesque',
        ),
        highlightStyle: TextStyle(
          color: TWColors.yellow.shade400,
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'BricolageGrotesque',
        ),
      ),
    );
  }
}

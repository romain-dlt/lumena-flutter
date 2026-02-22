import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class RatingDialog extends StatelessWidget {
  const RatingDialog({super.key});

  Future<void> _openPlayStore() async {
    final uri = Uri.parse(
      'https://play.google.com/store/apps/details?id=com.romaindelatte.lumena',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: TWColors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40.r),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: TWColors.slate.shade50.withAlpha(125),
              borderRadius: BorderRadius.circular(40.r),
              border: Border.all(color: TWColors.slate.shade300, width: 1.w),
            ),
            padding: EdgeInsets.all(20.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.t.rateUsTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: TWColors.slate.shade900,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  context.t.rateUsDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: TWColors.slate.shade800,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  spacing: 16.w,
                  children: [_rateButton(context), _noThanksButton(context)],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _rateButton(BuildContext context) {
    return Flexible(
      child: TappableWrapper(
        onTap: () {
          _openPlayStore();
          Navigator.of(context).pop();
        },
        child: FilledButton(
          onPressed: () {
            _openPlayStore();
            Navigator.of(context).pop();
          },
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
            backgroundColor: TWColors.blue.shade600,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/star.svg',
                width: 20.w,
                colorFilter: ColorFilter.mode(
                  TWColors.slate.shade50,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                context.t.rateUsButton,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: TWColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _noThanksButton(BuildContext context) {
    return Flexible(
      child: TappableWrapper(
        onTap: () => Navigator.of(context).pop(),
        child: FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 24.w),
            backgroundColor: TWColors.slate.shade50.withAlpha(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999.r),
            ),
          ),
          child: Text(
            context.t.noThanks,
            style: TextStyle(fontSize: 16.sp, color: TWColors.slate.shade900),
          ),
        ),
      ),
    );
  }
}

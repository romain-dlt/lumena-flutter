import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumena_ai/widgets/widgets.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final String? iconPath;
  final String? iconPlacement;
  final bool? isDisabled;
  final VoidCallback? onPressed;
  final Color? overrideColor;
  final Color? overrideTextColor;

  const PrimaryButton({
    super.key,
    required this.label,
    this.iconPath,
    this.iconPlacement,
    this.isDisabled = false,
    this.onPressed,
    this.overrideColor,
    this.overrideTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return TappableWrapper(
      onTap: isDisabled! ? null : onPressed,
      enabled: !isDisabled!,
      child: FilledButton(
        onPressed: isDisabled! ? null : onPressed ?? () {},
        style: FilledButton.styleFrom(
          backgroundColor: overrideColor ?? TWColors.blue.shade600,
          padding: EdgeInsets.symmetric(vertical: 18.h),
          disabledBackgroundColor: overrideColor != null
              ? overrideColor?.withAlpha(180)
              : TWColors.blue.shade400,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null && iconPlacement == 'left') ...[
              SvgPicture.asset(
                iconPath!,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(
                  overrideTextColor ?? TWColors.slate.shade50,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 12.w),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 20.sp,
                color: overrideTextColor ?? TWColors.slate.shade50,
              ),
            ),
            if (iconPath != null && iconPlacement == 'right') ...[
              SizedBox(width: 12.w),
              SvgPicture.asset(
                iconPath!,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(
                  overrideTextColor ?? TWColors.slate.shade50,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

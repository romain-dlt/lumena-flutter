import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumena_ai/widgets/widgets.dart';

class FloatingEditButton extends StatelessWidget {
  const FloatingEditButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TappableWrapper(
      onTap: () {
        Navigator.pushNamed(context, '/edit');
      },
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            width: 80.w,
            height: 80.h,
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              color: TWColors.slate.shade100.withAlpha(125),
              border: Border.all(color: TWColors.slate.shade300, width: 1.5.w),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              'assets/icons/sparks.svg',
              colorFilter: ColorFilter.mode(
                TWColors.blue.shade600,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/widgets/widgets.dart';

class ImageSourceDialog extends StatelessWidget {
  final VoidCallback onCameraPress;
  final VoidCallback onGalleryPress;

  const ImageSourceDialog({
    super.key,
    required this.onCameraPress,
    required this.onGalleryPress,
  });

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
              border: Border.all(color: TWColors.slate.shade300, width: 1.w.w),
            ),
            padding: EdgeInsets.all(20.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  context.t.imageSource,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: TWColors.slate.shade900,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  context.t.imageSourceDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: TWColors.slate.shade800,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _button(
                      context,
                      context.t.camera,
                      'assets/icons/camera.svg',
                      onCameraPress,
                    ),
                    SizedBox(width: 12.w),
                    _button(
                      context,
                      context.t.gallery,
                      'assets/icons/gallery.svg',
                      onGalleryPress,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _button(
    BuildContext context,
    String label,
    String iconPath,
    VoidCallback onPress,
  ) {
    return Expanded(
      child: TappableWrapper(
        onTap: onPress,
        child: FilledButton(
          onPressed: onPress,
          style: FilledButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            backgroundColor: TWColors.slate.shade50.withAlpha(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999.r),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                iconPath,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(
                  TWColors.slate.shade800,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8.w),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: TWColors.slate.shade800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

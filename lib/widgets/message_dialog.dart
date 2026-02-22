import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/widgets/widgets.dart';

class MessageDialog extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onOkPress;

  const MessageDialog({
    super.key,
    required this.title,
    required this.description,
    required this.onOkPress,
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
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                    color: TWColors.slate.shade900,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: TWColors.slate.shade800,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(children: [_okButton(context, context.t.okay, onOkPress)]),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _okButton(BuildContext context, String label, VoidCallback onPress) {
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
          child: Text(
            label,
            style: TextStyle(fontSize: 16.sp, color: TWColors.slate.shade800),
          ),
        ),
      ),
    );
  }
}

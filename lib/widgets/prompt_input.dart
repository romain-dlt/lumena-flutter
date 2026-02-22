import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';

class PromptInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isDisabled;

  const PromptInput({
    super.key,
    required this.controller,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: isDisabled
                ? TWColors.slate.shade100.withAlpha(200)
                : TWColors.slate.shade50.withAlpha(200),
            border: Border.all(color: TWColors.slate.shade300),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: TextField(
            controller: controller,
            enabled: !isDisabled,
            keyboardType: TextInputType.multiline,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: context.t.promptInputPlaceholder,
              hintStyle: TextStyle(
                color: isDisabled
                    ? TWColors.slate.shade200
                    : TWColors.slate.shade400,
              ),
              border: InputBorder.none,
            ),
            style: TextStyle(fontSize: 16.sp, color: TWColors.slate.shade900),
          ),
        ),
      ),
    );
  }
}

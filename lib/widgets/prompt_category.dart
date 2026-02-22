import 'package:flutter/material.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:lumena_ai/models/models.dart';
import 'package:lumena_ai/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PromptCategory extends StatelessWidget {
  final PromptCategoryModel promptCategory;

  const PromptCategory({super.key, required this.promptCategory});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 20.w, top: 20.h),
          child: Text(
            promptCategory.label,
            style: TextStyle(
              color: TWColors.slate.shade900,
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(height: 14.h),
        SizedBox(
          height: 280.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: promptCategory.prompts.length,
            separatorBuilder: (context, index) => SizedBox(width: 14.w),
            itemBuilder: (context, index) {
              return Padding(
                padding: index == 0
                    ? EdgeInsets.only(left: 20.w)
                    : index == promptCategory.prompts.length - 1
                    ? EdgeInsets.only(right: 20.w)
                    : EdgeInsets.zero,
                child: AnimatedPromptImage(
                  prompt: promptCategory.prompts[index],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

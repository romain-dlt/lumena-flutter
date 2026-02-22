import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:lumena_ai/widgets/widgets.dart';

class BackHomeButton extends StatelessWidget {
  final VoidCallback? onTap;

  const BackHomeButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 16.0),
        child: TappableWrapper(
          onTap: onTap ?? () => Navigator.pop(context),
          child: SizedBox(
            width: 48.0,
            height: 48.0,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: TWColors.slate.shade50,
                shape: BoxShape.circle,
                border: Border.all(color: TWColors.slate.shade300, width: 1.0),
              ),
              child: SvgPicture.asset(
                'assets/icons/chevron-left.svg',
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(
                  TWColors.slate.shade900,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

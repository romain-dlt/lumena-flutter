import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumena_ai/widgets/widgets.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TappableWrapper(
      onTap: () => Navigator.of(context).pushNamed('/settings'),
      child: Container(
        margin: EdgeInsets.only(left: 24.w),
        child: SizedBox(
          width: 28.0,
          height: 28.0,
          child: SvgPicture.asset(
            'assets/icons/settings.svg',
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(
              TWColors.black,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

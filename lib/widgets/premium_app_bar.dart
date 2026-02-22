import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:lumena_ai/widgets/widgets.dart';

class PremiumAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PremiumAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: TWColors.blue.shade600,
      leading: TappableWrapper(
        onTap: () {
          // Retourner à la page d'accueil en supprimant toutes les routes
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/home', (route) => false);
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            width: 24.0,
            height: 24.0,
            child: SvgPicture.asset(
              'assets/icons/xmark.svg',
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(
                TWColors.slate.shade50.withAlpha(200),
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

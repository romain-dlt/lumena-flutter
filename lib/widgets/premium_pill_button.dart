import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/services/iap_service.dart';
import 'package:lumena_ai/widgets/widgets.dart';

class PremiumPillButton extends StatefulWidget {
  const PremiumPillButton({super.key});

  @override
  State<PremiumPillButton> createState() => _PremiumPillButtonState();
}

class _PremiumPillButtonState extends State<PremiumPillButton> {
  bool? isPro;

  @override
  void initState() {
    super.initState();
    _loadProState();
  }

  Future<void> _loadProState() async {
    final isProStatus = await IAPService.isPro();

    if (mounted) {
      setState(() {
        isPro = isProStatus;
      });
    }
  }

  Future<void> _showAlreadyProMessageDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => MessageDialog(
        title: context.t.alreadyPro,
        description: context.t.alreadyProDescription,
        onOkPress: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TappableWrapper(
      onTap: () => isPro == true
          ? _showAlreadyProMessageDialog()
          : Navigator.of(context).pushNamed('/premium-hook'),
      child: isPro == null
          ? const SizedBox.shrink()
          : Container(
              margin: EdgeInsets.only(right: 20.w),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: TWColors.blue.shade600,
                  borderRadius: BorderRadius.all(Radius.circular(999.r)),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/circle-bolt.svg',
                      colorFilter: ColorFilter.mode(
                        TWColors.slate.shade50,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'PRO',
                      style: TextStyle(
                        color: TWColors.slate.shade50,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

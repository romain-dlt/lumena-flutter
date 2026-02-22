import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/services/iap_service.dart';
import 'package:lumena_ai/services/services.dart';
import 'package:lumena_ai/utils/rich_text_helper.dart';
import 'package:lumena_ai/widgets/widgets.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PremiumPaywallPage extends StatefulWidget {
  const PremiumPaywallPage({super.key});

  @override
  State<PremiumPaywallPage> createState() => _PremiumPaywallPageState();
}

class _PremiumPaywallPageState extends State<PremiumPaywallPage> {
  bool _isLoading = true;
  String _selectedPlan = 'monthly';
  Package? _selectedPackage;
  Package? _monthlyPackage;
  Package? _weeklyPackage;
  bool _isEligibleForFreeTrial = true;

  @override
  void initState() {
    super.initState();
    _initializeAndLoadPackages();
  }

  Future<void> _initializeAndLoadPackages() async {
    try {
      // S'assurer que l'utilisateur est lié à RevenueCat
      final currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser != null) {
        await IAPService.loginUser(currentUser.id);
      }
    } catch (e) {
      print('Error initializing user in RevenueCat: $e');
    }

    // Charger les packages
    await _loadPackages();
  }

  Future<void> _loadPackages() async {
    try {
      final offerings = await IAPService.getOfferings();
      if (!mounted) return;

      setState(() {
        _monthlyPackage = offerings.current?.monthly;
        _weeklyPackage = offerings.current?.weekly;

        // Vérifier l'éligibilité au free trial
        // L'utilisateur est éligible si l'introductoryPrice est disponible
        _isEligibleForFreeTrial =
            _monthlyPackage?.storeProduct.introductoryPrice != null ||
            _weeklyPackage?.storeProduct.introductoryPrice != null;

        // Sélectionner le premier package disponible
        if (_monthlyPackage != null) {
          _selectedPackage = _monthlyPackage;
          _selectedPlan = 'monthly';
        } else if (_weeklyPackage != null) {
          _selectedPackage = _weeklyPackage;
          _selectedPlan = 'weekly';
        }

        _isLoading = false;
      });

      // Si aucun package n'est disponible après le chargement
      if (_monthlyPackage == null && _weeklyPackage == null) {
        print('Warning: No packages available in current offering');
        print('Offerings current: ${offerings.current?.identifier}');
        print('All offerings: ${offerings.all.keys.toList()}');

        // Afficher le dialogue d'erreur si vraiment aucun package
        if (mounted) {
          await _showErrorMessageDialog();
        }
      }
    } catch (e) {
      print('Error loading packages: $e');
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      // Afficher un message d'erreur à l'utilisateur
      if (mounted) {
        await _showErrorMessageDialog();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PremiumAppBar(),
      backgroundColor: TWColors.blue.shade600,
      body: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(spacing: 20.h, children: [_title(), _stepsShowcase()]),
              Column(
                spacing: 20.h,
                children: [
                  if (!_isEligibleForFreeTrial)
                    Text(
                      context.t.notEligibleForFreeTrial,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: TWColors.slate.shade50,
                        fontSize: 14.sp,
                      ),
                    ),
                  _pricePlanCard(
                    context.t.monthly,
                    context.t.pricePerMonth(
                      _monthlyPackage?.storeProduct.priceString ?? '...',
                    ),
                    context.t.editsPerMonth(
                      int.parse(dotenv.env['PREMIUM_MAX_MONTHLY_EDITS'] ?? '0'),
                    ),
                    _monthlyPackage?.storeProduct.priceString ?? '...',
                    _selectedPlan == 'monthly',
                    () {
                      if (_monthlyPackage != null) {
                        setState(() {
                          _selectedPlan = 'monthly';
                          _selectedPackage = _monthlyPackage;
                        });
                      }
                    },
                  ),
                  _pricePlanCard(
                    context.t.weekly,
                    context.t.pricePerWeek(
                      _weeklyPackage?.storeProduct.priceString ?? '...',
                    ),
                    context.t.editsPerMonth(
                      int.parse(dotenv.env['PREMIUM_MAX_MONTHLY_EDITS'] ?? '0'),
                    ),
                    _weeklyPackage?.storeProduct.priceString ?? '...',
                    _selectedPlan == 'weekly',
                    () {
                      if (_weeklyPackage != null) {
                        setState(() {
                          _selectedPlan = 'weekly';
                          _selectedPackage = _weeklyPackage;
                        });
                      }
                    },
                  ),
                  Column(
                    spacing: 10.h,
                    children: [
                      PrimaryButton(
                        label: context.t.subscribeForPrice(
                          _selectedPackage?.storeProduct.priceString ?? '...',
                        ),
                        iconPath: 'assets/icons/circle-bolt.svg',
                        iconPlacement: 'left',
                        onPressed: _handleSubscribe,
                        overrideColor: TWColors.slate.shade50,
                        overrideTextColor: TWColors.blue.shade600,
                        isDisabled: _isLoading || _selectedPackage == null,
                      ),
                      Text(
                        context.t.noCommitmentCancelAnytime,
                        style: TextStyle(
                          color: TWColors.slate.shade50.withAlpha(200),
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showErrorMessageDialog() async {
    return await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => MessageDialog(
        title: context.t.purchaseFailure,
        description: context.t.purchaseFailureDescription,
        onOkPress: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop(); // Retour à la page précédente
        },
      ),
    );
  }

  Future<void> _showSuccessMessageDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => MessageDialog(
        title: context.t.congratulations,
        description: context.t.congratulationsDescription,
        onOkPress: () {
          Navigator.of(
            context,
          ).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
        },
      ),
    );
  }

  Future<void> _handleSubscribe() async {
    if (_selectedPackage == null) return;

    setState(() {
      _isLoading = true;
    });

    final isSuccess = await IAPService.purchase(
      _selectedPackage!,
      _showErrorMessageDialog,
      notificationTitle: context.t.freeTrialExpirationTitle,
      notificationBody: context.t.freeTrialExpirationBody,
    );

    setState(() {
      _isLoading = false;
    });

    if (isSuccess) {
      await _showSuccessMessageDialog();
    }
  }

  TappableWrapper _pricePlanCard(
    String period,
    String periodPrice,
    String periodEdits,
    String price,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return TappableWrapper(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: TWColors.slate.shade50,
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 5.h,
                  ),
                  decoration: BoxDecoration(
                    color: _isEligibleForFreeTrial
                        ? TWColors.blue.shade700
                        : TWColors.slate.shade300,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    context.t.threeDayFreeTrial,
                    style: TextStyle(
                      color: _isEligibleForFreeTrial
                          ? TWColors.slate.shade50
                          : TWColors.slate.shade400,
                      decoration: _isEligibleForFreeTrial
                          ? TextDecoration.none
                          : TextDecoration.lineThrough,
                      decorationColor: TWColors.slate.shade400,
                      decorationThickness: 2.0,
                    ),
                  ),
                ),
                Container(
                  width: 18.w,
                  height: 18.w,
                  margin: EdgeInsets.only(right: 10.w, top: 8.h),
                  padding: EdgeInsets.all(1.w),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: TWColors.blue.shade600,
                      width: 1.5.w,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(999.r)),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? TWColors.blue.shade600
                          : TWColors.transparent,
                      borderRadius: BorderRadius.all(Radius.circular(999.r)),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        period,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: TWColors.blue.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        periodPrice,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: TWColors.blue.shade600.withAlpha(200),
                        ),
                      ),
                      Text(
                        periodEdits,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: TWColors.blue.shade600.withAlpha(200),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: TWColors.blue.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  RichText _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: RichTextHelper.parseHighlightedText(
        context.t.howFreeTrialWorks,
        baseStyle: TextStyle(
          color: TWColors.slate.shade50,
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'BricolageGrotesque',
        ),
        highlightStyle: TextStyle(
          color: TWColors.yellow.shade400,
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
          fontFamily: 'BricolageGrotesque',
        ),
      ),
    );
  }

  Row _stepsShowcase() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 20.w,
      children: [
        Column(
          children: [
            _circleIcon('assets/icons/unlock.svg'),
            Transform.translate(
              offset: Offset(0, -4.h),
              child: Container(
                width: 15.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: TWColors.slate.shade50.withAlpha(220),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -8.h),
              child: _circleIcon('assets/icons/bell.svg'),
            ),
            Transform.translate(
              offset: Offset(0, -12.h),
              child: Container(
                width: 15.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: TWColors.slate.shade50.withAlpha(220),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, -16.h),
              child: _circleIcon('assets/icons/bolt.svg'),
            ),
            Transform.translate(
              offset: Offset(0, -20.h),
              child: Container(
                width: 15.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: TWColors.slate.shade50.withAlpha(150),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(999.r),
                    bottomRight: Radius.circular(999.r),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _stepText(context.t.step1Title, context.t.step1Description),
              SizedBox(height: 30.h),
              _stepText(context.t.step2Title, context.t.step2Description),
              SizedBox(height: 10.h),
              _stepText(context.t.step3Title, context.t.step3Description),
            ],
          ),
        ),
      ],
    );
  }

  Column _stepText(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: TWColors.slate.shade50,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          description,
          softWrap: true,
          maxLines: 3,
          style: TextStyle(
            color: TWColors.slate.shade50.withAlpha(200),
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }

  Container _circleIcon(String iconPath) {
    return Container(
      width: 40.w,
      height: 40.w,
      padding: EdgeInsets.all(9.w),
      decoration: BoxDecoration(
        color: TWColors.slate.shade50,
        borderRadius: BorderRadius.circular(999),
      ),
      child: SvgPicture.asset(
        iconPath,
        colorFilter: ColorFilter.mode(TWColors.blue.shade600, BlendMode.srcIn),
      ),
    );
  }
}

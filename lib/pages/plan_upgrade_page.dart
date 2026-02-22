import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/services/iap_service.dart';
import 'package:lumena_ai/widgets/widgets.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PlanUpgradePage extends StatefulWidget {
  const PlanUpgradePage({super.key});

  @override
  State<PlanUpgradePage> createState() => _PlanUpgradePageState();
}

class _PlanUpgradePageState extends State<PlanUpgradePage> {
  bool _isLoading = true;
  bool _isPro = false;
  String? _currentPlanType; // 'weekly' or 'monthly'
  late Package _selectedPackage;
  Package? _monthlyPackage;
  Package? _weeklyPackage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final proStatus = await IAPService.isPro();
    final offerings = await IAPService.getOfferings();
    String? currentPlan;

    if (proStatus) {
      // Détecter le plan actuel de l'utilisateur PRO
      final customerInfo = await IAPService.getCustomerInfo();
      final activeSubscriptions = customerInfo.activeSubscriptions;

      if (activeSubscriptions.isNotEmpty) {
        final activeProductId = activeSubscriptions.first;
        // Vérifier si c'est un plan hebdomadaire ou mensuel
        if (offerings.current?.weekly?.storeProduct.identifier ==
            activeProductId) {
          currentPlan = 'weekly';
        } else if (offerings.current?.monthly?.storeProduct.identifier ==
            activeProductId) {
          currentPlan = 'monthly';
        }
      }
    }

    setState(() {
      _isPro = proStatus;
      _currentPlanType = currentPlan;
      _monthlyPackage = offerings.current?.monthly;
      _weeklyPackage = offerings.current?.weekly;

      // Sélectionner le plan opposé par défaut pour les utilisateurs PRO
      if (_isPro && _currentPlanType == 'weekly' && _monthlyPackage != null) {
        _selectedPackage = _monthlyPackage!;
      } else if (_isPro &&
          _currentPlanType == 'monthly' &&
          _weeklyPackage != null) {
        _selectedPackage = _weeklyPackage!;
      } else if (_monthlyPackage != null) {
        _selectedPackage = _monthlyPackage!;
      }
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.t.changePlan,
        leading: BackHomeButton(onTap: () => Navigator.of(context).pop()),
      ),
      backgroundColor: TWColors.slate.shade200,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(color: TWColors.blue.shade600),
            )
          : Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                spacing: 20.h,
                children: [_currentPlanCard(), _availablePlansSection()],
              ),
            ),
    );
  }

  Widget _currentPlanCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: TWColors.slate.shade50,
        border: Border.all(color: TWColors.slate.shade300, width: 1.w),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: _isPro ? TWColors.blue.shade100 : TWColors.slate.shade200,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: SvgPicture.asset(
              'assets/icons/circle-bolt.svg',
              width: 24.w,
              colorFilter: ColorFilter.mode(
                TWColors.blue.shade600,
                BlendMode.srcIn,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  context.t.currentPlan,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: TWColors.slate.shade500,
                  ),
                ),
                Text(
                  _currentPlanType == 'weekly'
                      ? 'Lumena PRO (${context.t.weekly})'
                      : _currentPlanType == 'monthly'
                      ? 'Lumena PRO (${context.t.monthly})'
                      : 'Lumena PRO',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: TWColors.slate.shade900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _availablePlansSection() {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        spacing: 20.h,
        children: [
          if (_currentPlanType == 'weekly') ...[
            Column(
              spacing: 20.h,
              children: [
                Text(
                  context.t.changeYourPlanToMonthly,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: TWColors.slate.shade900,
                  ),
                ),
                // Utilisateur Weekly peut upgrade vers Monthly
                _planCard(
                  title: context.t.monthlyPlan,
                  price:
                      _monthlyPackage?.storeProduct.priceString ??
                      context.t.fetchingPrice,
                  period: '/ ${context.t.month}',
                ),
              ],
            ),
            Column(
              spacing: 20.h,
              children: [
                PrimaryButton(
                  label: context.t.upgradeToMonthly,
                  iconPath: 'assets/icons/circle-bolt.svg',
                  iconPlacement: 'left',
                  onPressed: _handleChangePlan,
                ),
                _managementButtons(),
              ],
            ),
          ],
          if (_currentPlanType == 'monthly') ...[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 20.h,
              children: [
                Text(
                  context.t.changeYourPlanToWeekly,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: TWColors.slate.shade900,
                  ),
                ),
                // Utilisateur Monthly peut downgrade vers Weekly
                _planCard(
                  title: context.t.weeklyPlan,
                  price:
                      _weeklyPackage?.storeProduct.priceString ??
                      context.t.fetchingPrice,
                  period: '/ ${context.t.week}',
                ),
              ],
            ),
            Column(
              spacing: 20.h,
              children: [
                PrimaryButton(
                  label: context.t.switchToWeekly,
                  iconPath: 'assets/icons/circle-bolt.svg',
                  iconPlacement: 'left',
                  onPressed: _handleChangePlan,
                ),
                _managementButtons(),
              ],
            ),
          ],
          if (_currentPlanType == null) ...[
            // Utilisateur PRO mais plan non détecté
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(
                color: TWColors.orange.shade50,
                border: Border.all(color: TWColors.orange.shade300, width: 1.w),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                spacing: 8.h,
                children: [
                  Icon(
                    Icons.warning_rounded,
                    color: TWColors.orange.shade600,
                    size: 32.w,
                  ),
                  Text(
                    context.t.unableToDetectCurrentPlan,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: TWColors.slate.shade900,
                    ),
                  ),
                  Text(
                    context.t.unableToDetectCurrentPlanDescription,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: TWColors.slate.shade600,
                    ),
                  ),
                ],
              ),
            ),
            _managementButtons(),
          ],
        ],
      ),
    );
  }

  Widget _planCard({
    required String title,
    required String price,
    required String period,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: TWColors.slate.shade50,
        border: Border.all(color: TWColors.blue.shade600, width: 1.5.w),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12.h,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: TWColors.slate.shade900,
                ),
              ),
              Container(
                width: 20.w,
                height: 20.w,
                margin: EdgeInsets.only(right: 4.w),
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
                    color: TWColors.blue.shade600,
                    borderRadius: BorderRadius.all(Radius.circular(999.r)),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                price,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: TWColors.blue.shade600,
                ),
              ),
              SizedBox(width: 4.w),
              Padding(
                padding: EdgeInsets.only(bottom: 4.h),
                child: Text(
                  period,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: TWColors.slate.shade600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _managementButtons() {
    return Column(
      spacing: 12.h,
      children: [
        PrimaryButton(
          label: context.t.cancelSubscription,
          iconPath: 'assets/icons/circle-xmark.svg',
          iconPlacement: 'left',
          onPressed: _showCancelSubscriptionDialog,
          overrideColor: TWColors.red.shade600,
        ),
        Text(
          context.t.subscriptionActiveNotice,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12.sp, color: TWColors.slate.shade500),
        ),
      ],
    );
  }

  Future<void> _handleChangePlan() async {
    setState(() {
      _isLoading = true;
    });

    // RevenueCat gère automatiquement les changements d'abonnement
    // En production, il détectera l'abonnement existant et appliquera le prorata
    final isSuccess = await IAPService.purchase(
      _selectedPackage,
      _showErrorMessageDialog,
    );

    setState(() {
      _isLoading = false;
    });

    if (isSuccess) {
      await _showPlanChangeSuccessDialog();
    }
  }

  Future<void> _showPlanChangeSuccessDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => MessageDialog(
        title: context.t.planChanged,
        description: context.t.planChangedDescription,
        onOkPress: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop(); // Go back to settings
        },
      ),
    );
  }

  Future<void> _showErrorMessageDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => MessageDialog(
        title: context.t.planChangeFailed,
        description: context.t.planChangeFailedDescription,
        onOkPress: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> _showCancelSubscriptionDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        title: context.t.cancelSubscriptionQuestion,
        description: context.t.cancelSubscriptionDescription,
        confirmLabel: context.t.cancel,
        cancelLabel: context.t.keepPro,
        onConfirm: () {
          Navigator.of(context).pop();
          _showCancelInfoDialog();
        },
        onCancel: () => Navigator.of(context).pop(),
      ),
    );
  }

  Future<void> _showCancelInfoDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => MessageDialog(
        title: context.t.cancelSubscription,
        description: context.t.cancelSubscriptionDescription,
        onOkPress: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }
}

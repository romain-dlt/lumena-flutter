import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/services/auth_service.dart';
import 'package:lumena_ai/services/monthly_edits_service.dart';
import 'package:lumena_ai/services/iap_service.dart';
import 'package:lumena_ai/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  int? _remainingEdits;
  int? _maxEdits;
  bool? isPro;

  @override
  void initState() {
    super.initState();
    final Future<void> a = _loadRemainingEdits();
    final Future<void> b = _loadMaxEdits();
    final Future<void> c = _loadProState();
    Future.wait([a, b, c]);
  }

  Future<void> _loadProState() async {
    final proStatus = await IAPService.isPro();

    setState(() {
      isPro = proStatus;
    });
  }

  Future<void> _loadRemainingEdits() async {
    if (AuthService.isAuthenticated()) {
      final remaining = await MonthlyEditsService.getRemainingEdits();
      setState(() {
        _remainingEdits = remaining;
      });
    } else {
      setState(() {
        _remainingEdits = null;
      });
    }
  }

  Future<void> _loadMaxEdits() async {
    if (AuthService.isAuthenticated()) {
      final maxEdits = await IAPService.isPro()
          ? int.parse(dotenv.env['PREMIUM_MAX_MONTHLY_EDITS'] ?? '0')
          : 0;
      setState(() {
        _maxEdits = maxEdits;
      });
    } else {
      setState(() {
        _maxEdits = null;
      });
    }
  }

  /// Recharge toutes les données de la page
  Future<void> _refreshData() async {
    await Future.wait([
      _loadRemainingEdits(),
      _loadMaxEdits(),
      _loadProState(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.t.settings,
        leading: BackHomeButton(onTap: () => Navigator.of(context).pop()),
        actions: [PremiumPillButton()],
      ),
      backgroundColor: TWColors.slate.shade200,
      body: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          spacing: 20.h,
          children: [
            _categoryCard(context.t.account, [
              _emailRow(context),
              _monthlyEditsUsageRow(),
              if (AuthService.isAuthenticated()) _signOutRow(context),
            ]),
            if (AuthService.isAuthenticated())
              _categoryCard(context.t.lumenaPro, [
                isPro == true
                    ? _changePlanRow(context)
                    : _restorePurchasesRow(context),
              ]),
            _categoryCard(context.t.legal, [
              _legalLink(context.t.website, 'https://www.trylumena.app'),
              _legalLink(
                context.t.legalNotice,
                'https://www.trylumena.app/legal/notice',
              ),
              _legalLink(
                context.t.termsOfService,
                'https://www.trylumena.app/legal/terms',
              ),
              _legalLink(
                context.t.privacyPolicy,
                'https://www.trylumena.app/legal/privacy',
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Future<void> _showRestoreFailedMessageDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => MessageDialog(
        title: context.t.restoreFailed,
        description: context.t.restoreFailedDescription,
        onOkPress: () => Navigator.of(context).pop(),
      ),
    );
  }

  Row _changePlanRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.t.changePlan,
          style: TextStyle(fontSize: 16.sp, color: TWColors.slate.shade900),
        ),
        TappableWrapper(
          onTap: () => Navigator.of(context).pushNamed('/plan-upgrade'),
          child: Row(
            spacing: 4.w,
            children: [
              Text(
                isPro == true ? context.t.manage : context.t.upgrade,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: TWColors.slate.shade500,
                ),
              ),
              SvgPicture.asset(
                'assets/icons/chevron-right.svg',
                width: 18.w,
                colorFilter: ColorFilter.mode(
                  TWColors.slate.shade500,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _signOutRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.t.signOut,
          style: TextStyle(fontSize: 16.sp, color: TWColors.slate.shade900),
        ),
        TappableWrapper(
          onTap: () => {
            showDialog<bool>(
              context: context,
              builder: (context) => ConfirmDialog(
                title: context.t.signOutConfirmation,
                description: context.t.signOutDescription,
                confirmLabel: context.t.signOut,
                cancelLabel: context.t.cancel,
                onConfirm: () => AuthService.signOut(context),
                onCancel: () => Navigator.of(context).pop(false),
              ),
            ),
          },
          child: Row(
            spacing: 4.w,
            children: [
              Text(
                context.t.signOut,
                style: TextStyle(fontSize: 16.sp, color: TWColors.red.shade600),
              ),
              SvgPicture.asset(
                'assets/icons/chevron-right.svg',
                width: 18.w,
                colorFilter: ColorFilter.mode(
                  TWColors.red.shade600,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Row _monthlyEditsUsageRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.t.monthlyEditsUsage,
          style: TextStyle(fontSize: 16.sp, color: TWColors.slate.shade900),
        ),
        Flexible(
          child: Text(
            !AuthService.isAuthenticated()
                ? context.t.signInToView
                : _remainingEdits != null
                ? context.t.remaining(_remainingEdits ?? 0, _maxEdits ?? 0)
                : context.t.counting,
            style: TextStyle(fontSize: 16.sp, color: TWColors.slate.shade500),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }

  Row _restorePurchasesRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.t.restorePurchases,
          style: TextStyle(fontSize: 16.sp, color: TWColors.slate.shade900),
        ),
        TappableWrapper(
          onTap: _handleRestorePurchases,
          child: Row(
            spacing: 4.w,
            children: [
              Text(
                context.t.restore,
                style: TextStyle(
                  fontSize: 16.sp,
                  color: TWColors.slate.shade500,
                ),
              ),
              SvgPicture.asset(
                'assets/icons/chevron-right.svg',
                width: 18.w,
                colorFilter: ColorFilter.mode(
                  TWColors.slate.shade500,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _handleRestorePurchases() async {
    await IAPService.restorePurchases(
      _showRestoreSuccessMessageDialog,
      _showRestoreFailedMessageDialog,
      _showNoPurchasesToRestoreMessageDialog,
    );
  }

  Future<void> _showNoPurchasesToRestoreMessageDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => MessageDialog(
        title: context.t.noPurchases,
        description: context.t.noPurchasesDescription,
        onOkPress: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<void> _showRestoreSuccessMessageDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => MessageDialog(
        title: context.t.restoreSuccessful,
        description: context.t.restoreSuccessfulDescription,
        onOkPress: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Row _emailRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          context.t.email,
          style: TextStyle(fontSize: 16.sp, color: TWColors.slate.shade900),
        ),
        AuthService.isAuthenticated()
            ? Text(
                AuthService.getUser()?.email ?? 'N/A',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: TWColors.slate.shade500,
                ),
              )
            : TappableWrapper(
                onTap: () async {
                  // Attendre le retour de la page de connexion
                  await Navigator.of(context).pushNamed('/sign-in');
                  // Recharger les données après connexion
                  await _refreshData();
                },
                child: Row(
                  spacing: 4.w,
                  children: [
                    Text(
                      context.t.signIn,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: TWColors.slate.shade500,
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/icons/chevron-right.svg',
                      width: 18.w,
                      colorFilter: ColorFilter.mode(
                        TWColors.slate.shade500,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  TappableWrapper _legalLink(String label, String url) {
    return TappableWrapper(
      onTap: () async {
        final Uri uri = Uri.parse(url);

        if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
          throw 'Could not launch $uri';
        }
      },
      child: Row(
        spacing: 8.w,
        children: [
          SvgPicture.asset(
            'assets/icons/link.svg',
            width: 18.w,
            colorFilter: ColorFilter.mode(
              TWColors.slate.shade900,
              BlendMode.srcIn,
            ),
          ),
          Text(
            label,
            style: TextStyle(color: TWColors.slate.shade900, fontSize: 16.sp),
          ),
        ],
      ),
    );
  }

  Container _categoryCard(String label, List<Widget> children) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: TWColors.slate.shade50,
        border: Border.all(color: TWColors.slate.shade300, width: 1.w),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10.h,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 14.sp, color: TWColors.slate.shade500),
          ),
          ...children,
        ],
      ),
    );
  }
}

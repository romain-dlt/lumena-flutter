import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/services/services.dart';
import 'package:lumena_ai/widgets/widgets.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

class EditPage extends StatefulWidget {
  final String? initialPrompt;
  final String? initialImage;

  const EditPage({super.key, this.initialPrompt, this.initialImage});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late final TextEditingController _promptController;
  bool _isPictureInputEmpty = true;
  bool _isGenerateButtonDisabled = true;
  XFile? _selectedFile;
  bool _isLoading = false;
  bool _isEditingMode = true;
  int? _remainingEdits;
  final GlobalKey _bottomContentKey = GlobalKey();
  bool _isLoadingInitialImage = false;

  @override
  void initState() {
    super.initState();
    _promptController = TextEditingController(text: widget.initialPrompt);
    _promptController.addListener(_updateGenerateButtonState);
    _loadRemainingEdits();
    _loadInitialImage();
  }

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
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

  Future<void> _loadInitialImage() async {
    if (widget.initialImage != null) {
      setState(() {
        _isLoadingInitialImage = true;
      });

      XFile? file;

      // Si c'est une URL externe, la télécharger
      if (widget.initialImage!.startsWith('http://') ||
          widget.initialImage!.startsWith('https://')) {
        try {
          final response = await http.get(Uri.parse(widget.initialImage!));
          if (response.statusCode == 200) {
            final tempDir = await getTemporaryDirectory();
            final tempFile = File(
              '${tempDir.path}/temp_network_${DateTime.now().millisecondsSinceEpoch}.png',
            );
            await tempFile.writeAsBytes(response.bodyBytes);
            file = XFile(tempFile.path);
          }
        } catch (e) {
          // En cas d'erreur, ne rien faire
        }
      }
      // Si c'est un asset, le charger avec rootBundle
      else if (widget.initialImage!.startsWith('assets/')) {
        try {
          final byteData = await rootBundle.load(widget.initialImage!);
          final bytes = byteData.buffer.asUint8List();
          final tempDir = await getTemporaryDirectory();
          final tempFile = File(
            '${tempDir.path}/temp_asset_${DateTime.now().millisecondsSinceEpoch}.png',
          );
          await tempFile.writeAsBytes(bytes);
          file = XFile(tempFile.path);
        } catch (e) {
          // En cas d'erreur, ne rien faire
        }
      } else {
        // Sinon, c'est déjà un fichier
        file = XFile(widget.initialImage!);
      }

      if (file != null) {
        setState(() {
          _selectedFile = file;
          _isPictureInputEmpty = false;
          _isLoadingInitialImage = false;
        });
        _updateGenerateButtonState();
      } else {
        setState(() {
          _isLoadingInitialImage = false;
        });
      }
    }

    // Vérifier si le prompt contient des paramètres et afficher le dialog
    if (widget.initialPrompt != null &&
        widget.initialPrompt!.contains(RegExp(r'\[.+?\]'))) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showParametersReminderDialog();
        }
      });
    }
  }

  Future<void> _showParametersReminderDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => MessageDialog(
        title: context.t.parametersReminderTitle,
        description: context.t.parametersReminderDescription,
        onOkPress: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  void _updateGenerateButtonState() {
    setState(() {
      _isGenerateButtonDisabled =
          _isPictureInputEmpty || _promptController.text.trim().isEmpty;
    });
  }

  void _onFileUpdate(XFile? file) {
    setState(() {
      _isPictureInputEmpty = file == null;
      _selectedFile = file;
    });

    _updateGenerateButtonState();
  }

  bool _hasUnsavedChanges() {
    return !_isPictureInputEmpty || _promptController.text.trim().isNotEmpty;
  }

  Future<void> _handleGenerate() async {
    setState(() => _isLoading = true);

    if (!AuthService.isAuthenticated()) {
      if (mounted) {
        final result = await Navigator.of(context).pushNamed('/sign-in');

        if (result == true && mounted) {
          await _loadRemainingEdits();
        }
      }

      setState(() => _isLoading = false);

      return;
    }

    final canEdit = await MonthlyEditsService.consumeEdit();

    if (!mounted) return;

    if (!canEdit) {
      final bool isPro = await IAPService.isPro();

      if (mounted) {
        await showDialog(
          context: context,
          builder: (context) => PremiumEditsDialog(isPro: isPro),
        );
      }

      setState(() => _isLoading = false);

      return;
    }

    final resultImage = await APIService.editImage(
      base64Image: base64Encode(await _selectedFile!.readAsBytes()),
      prompt: _promptController.text.trim(),
      mimeType: _selectedFile!.mimeType ?? 'image/jpeg',
      onError: () {
        _showErrorMessageDialog();
        MonthlyEditsService.removeOneUsedEdit();
      },
    );

    if (resultImage == null) {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      return;
    }

    final tempDir = await getTemporaryDirectory();
    final fileName =
        'lumena_generated_${DateTime.now().millisecondsSinceEpoch}.jpg';
    final file = File('${tempDir.path}/$fileName');
    await file.writeAsBytes(base64Decode(resultImage));

    if (!mounted) return;

    setState(() {
      _selectedFile = XFile(file.path);
      _isLoading = false;
      _isEditingMode = false;
      _promptController.clear();
    });

    await _loadRemainingEdits();

    // Vérifier si on peut afficher le dialogue de notation
    if (mounted) {
      final canShow = await RatingService.canShowRatingDialog();
      if (canShow && mounted) {
        await RatingService.markDialogShown();
        await showDialog(
          context: context,
          builder: (context) => const RatingDialog(),
        );
      }
    }
  }

  Future<void> _handleDownload() async {
    if (_selectedFile == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final bytes = await _selectedFile!.readAsBytes();
      final result = await ImageGallerySaverPlus.saveImage(
        Uint8List.fromList(bytes),
        quality: 100,
        name: "lumena_ai_${DateTime.now().millisecondsSinceEpoch}",
      );

      if (mounted) {
        final isSuccess = result['isSuccess'] ?? false;

        return showDialog(
          context: context,
          builder: (context) => MessageDialog(
            title: isSuccess
                ? context.t.imageSavedToGallery
                : context.t.failedToSaveImage,
            description: isSuccess
                ? context.t.imageSavedToGalleryDescription
                : context.t.failedToSaveImageDescription,
            onOkPress: () {
              Navigator.of(context).pop();
            },
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        return showDialog(
          context: context,
          builder: (context) => MessageDialog(
            title: context.t.failedToSaveImage,
            description: context.t.failedToSaveImageDescription,
            onOkPress: () {
              Navigator.of(context).pop();
            },
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _handleShare() async {
    if (_selectedFile == null) return;

    await Share.shareXFiles([
      _selectedFile!,
    ], text: context.t.imageShareDescription);
  }

  void _handleKeepEditingPress() {
    setState(() {
      _isEditingMode = true;
    });
  }

  Future<void> _showErrorMessageDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => MessageDialog(
        title: context.t.unexpectedError,
        description: context.t.unexpectedErrorImageGenerationDescription,
        onOkPress: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Future<bool> _showExitConfirmation() async {
    if (!_hasUnsavedChanges()) {
      return true;
    }

    return await showDialog<bool>(
          context: context,
          builder: (context) => ConfirmDialog(
            title: context.t.exitConfirmTitle,
            description: context.t.exitConfirmDescription,
            confirmLabel: context.t.exit,
            cancelLabel: context.t.stayHere,
            onConfirm: () => Navigator.of(context).pop(true),
            onCancel: () => Navigator.of(context).pop(false),
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return PopScope(
      canPop: !_hasUnsavedChanges(),
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;

        final shouldPop = await _showExitConfirmation();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: context.t.photoEditor,
          leading: BackHomeButton(
            onTap: () async {
              final shouldPop = await _showExitConfirmation();
              if (shouldPop && context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
          actions: [PremiumPillButton()],
        ),
        backgroundColor: TWColors.slate.shade200,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Obtenir la hauteur réelle du contenu en bas
              double bottomContentHeight = 0;
              WidgetsBinding.instance.addPostFrameCallback((_) {
                final RenderBox? renderBox =
                    _bottomContentKey.currentContext?.findRenderObject()
                        as RenderBox?;
                if (renderBox != null && mounted) {
                  final newHeight = renderBox.size.height;
                  if (newHeight != bottomContentHeight) {
                    setState(() {});
                  }
                }
              });

              final RenderBox? renderBox =
                  _bottomContentKey.currentContext?.findRenderObject()
                      as RenderBox?;
              if (renderBox != null) {
                bottomContentHeight = renderBox.size.height;
              }

              return Stack(
                children: [
                  // PictureInput avec padding en bas pour ne pas être coupé
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: bottomContentHeight,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
                      child: _isLoadingInitialImage
                          ? SkeletonLoader(
                              borderRadius: BorderRadius.circular(16),
                            )
                          : PictureInput(
                              onFileUpdate: _onFileUpdate,
                              initialFile: _selectedFile,
                              isLoading: _isLoading,
                              isEditable: _isEditingMode,
                            ),
                    ),
                  ),
                  // Les inputs et boutons en position absolue au-dessus du clavier
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: keyboardHeight,
                    child: Container(
                      key: _bottomContentKey,
                      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _isEditingMode
                              ? _editModeInputs()
                              : _resultModeInputs(),
                          SizedBox(height: 10.h),
                          if (AuthService.isAuthenticated())
                            Text(
                              _remainingEdits != null
                                  ? context.t.editsRemainingThisMonth(
                                      _remainingEdits ?? 0,
                                    )
                                  : context.t.checkingEditBalance,
                              style: TextStyle(
                                color: TWColors.slate.shade500,
                                fontSize: 14.sp,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Column _resultModeInputs() {
    return Column(
      spacing: 20.h,
      children: [
        PrimaryButton(
          label: context.t.keepEditing,
          iconPath: 'assets/icons/pencil.svg',
          iconPlacement: 'left',
          onPressed: _handleKeepEditingPress,
          isDisabled: _isLoading,
        ),
        Row(
          spacing: 20.w,
          children: [
            Flexible(
              child: PrimaryButton(
                label: context.t.download,
                iconPath: 'assets/icons/download.svg',
                iconPlacement: 'left',
                onPressed: _handleDownload,
                overrideColor: TWColors.indigo.shade600,
                isDisabled: _isLoading,
              ),
            ),
            Flexible(
              child: PrimaryButton(
                label: context.t.share,
                iconPath: 'assets/icons/share.svg',
                iconPlacement: 'left',
                onPressed: _handleShare,
                overrideColor: TWColors.indigo.shade600,
                isDisabled: _isLoading,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _editModeInputs() {
    return Column(
      children: [
        PromptInput(controller: _promptController, isDisabled: _isLoading),
        SizedBox(height: 20.h),
        PrimaryButton(
          label: context.t.generate,
          iconPath: 'assets/icons/sparks.svg',
          iconPlacement: 'left',
          isDisabled: _isGenerateButtonDisabled || _isLoading,
          onPressed: _handleGenerate,
        ),
      ],
    );
  }
}

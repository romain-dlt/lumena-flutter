import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lumena_ai/l10n/l10n_extensions.dart';
import 'package:lumena_ai/widgets/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PictureInput extends StatefulWidget {
  final ValueChanged<XFile?>? onFileUpdate;
  final XFile? initialFile;
  final bool isLoading;
  final bool isEditable;

  const PictureInput({
    super.key,
    this.onFileUpdate,
    this.initialFile,
    this.isLoading = false,
    this.isEditable = true,
  });

  @override
  State<PictureInput> createState() => _PictureInputState();
}

class _PictureInputState extends State<PictureInput>
    with SingleTickerProviderStateMixin {
  File? _selectedImageFile;
  Uint8List? _selectedImageData;
  final ImagePicker _picker = ImagePicker();
  late AnimationController _sparkleController;
  String _currentLoadingSubtitle = '';
  int _lastLoadingSubtitleIndex = -1;

  List<String> _getLoadingSubtitles() {
    return [
      context.t.loadingSubtitle1,
      context.t.loadingSubtitle2,
      context.t.loadingSubtitle3,
      context.t.loadingSubtitle4,
      context.t.loadingSubtitle5,
      context.t.loadingSubtitle6,
      context.t.loadingSubtitle7,
      context.t.loadingSubtitle8,
    ];
  }

  @override
  void initState() {
    super.initState();
    _sparkleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    )..repeat();
    if (widget.isLoading) {
      _startSubtitleAnimation();
    }
    _loadInitialImage();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialiser le sous-titre une fois que context est disponible
    if (_currentLoadingSubtitle.isEmpty) {
      _currentLoadingSubtitle = _getLoadingSubtitles()[0];
    }
  }

  @override
  void dispose() {
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PictureInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialFile != oldWidget.initialFile) {
      _loadInitialImage();
    }
    // Démarrer l'animation des sous-titres quand isLoading devient true
    if (!oldWidget.isLoading && widget.isLoading) {
      _startSubtitleAnimation();
    }
  }

  void _startSubtitleAnimation() {
    Future.delayed(Duration(milliseconds: 2800), () {
      if (mounted && widget.isLoading) {
        setState(() {
          final loadingSubtitles = _getLoadingSubtitles();
          // Choisir un index différent du précédent
          int newIndex;
          do {
            newIndex = math.Random().nextInt(loadingSubtitles.length);
          } while (newIndex == _lastLoadingSubtitleIndex &&
              loadingSubtitles.length > 1);

          _lastLoadingSubtitleIndex = newIndex;
          _currentLoadingSubtitle = loadingSubtitles[newIndex];
        });
        _startSubtitleAnimation();
      }
    });
  }

  Future<void> _loadInitialImage() async {
    if (widget.initialFile == null) {
      setState(() {
        _selectedImageFile = null;
        _selectedImageData = null;
      });
      return;
    }

    try {
      // Essayer de créer un File si le path existe
      if (widget.initialFile!.path.isNotEmpty) {
        final file = File(widget.initialFile!.path);
        if (await file.exists()) {
          setState(() {
            _selectedImageFile = file;
            _selectedImageData = null;
          });
          return;
        }
      }
    } catch (e) {
      // Si File ne fonctionne pas, utiliser readAsBytes
    }

    // Sinon, charger les données en mémoire
    final bytes = await widget.initialFile!.readAsBytes();
    setState(() {
      _selectedImageFile = null;
      _selectedImageData = bytes;
    });
  }

  Future<void> _showImageSourceDialog() async {
    return await showDialog(
      context: context,
      builder: (context) => ImageSourceDialog(
        onCameraPress: () {
          Navigator.of(context).pop();
          _pickImage(true);
        },
        onGalleryPress: () {
          Navigator.of(context).pop();
          _pickImage(false);
        },
      ),
    );
  }

  Future<void> _pickImage(bool isCamera) async {
    final XFile? pickedFile = await _picker.pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _selectedImageFile = File(pickedFile.path);
        _selectedImageData = null;
        widget.onFileUpdate?.call(pickedFile);
      });
    }
  }

  bool get _hasImage =>
      _selectedImageFile != null || _selectedImageData != null;

  @override
  Widget build(BuildContext context) {
    return TappableWrapper(
      onTap: (widget.isLoading || !widget.isEditable)
          ? null
          : _showImageSourceDialog,
      enabled: !widget.isLoading && widget.isEditable,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: _hasImage ? EdgeInsets.zero : EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: TWColors.slate.shade50,
            border: _hasImage
                ? null
                : Border.all(color: TWColors.slate.shade300),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: !_hasImage
              ? _picturePlaceholder()
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: _selectedImageFile != null
                          ? Image.file(
                              _selectedImageFile!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            )
                          : Image.memory(
                              _selectedImageData!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                    ),
                    if (widget.isLoading)
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Stack(
                              children: [
                                Container(
                                  color: TWColors.slate.shade50.withAlpha(100),
                                ),
                                AnimatedBuilder(
                                  animation: _sparkleController,
                                  builder: (context, child) {
                                    return LayoutBuilder(
                                      builder: (context, constraints) {
                                        return CustomPaint(
                                          painter: SparklesPainter(
                                            animation: _sparkleController,
                                          ),
                                          size: Size(
                                            constraints.maxWidth,
                                            constraints.maxHeight,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/standalone-colored-lumena-icon.svg',
                                        width: 70.w,
                                      ),
                                      SizedBox(height: 16.h),
                                      Text(
                                        context.t.lumenaAI,
                                        style: TextStyle(
                                          fontSize: 24.sp,
                                          fontWeight: FontWeight.w600,
                                          color: TWColors.slate.shade900,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      AnimatedSwitcher(
                                        duration: Duration(milliseconds: 250),
                                        transitionBuilder: (child, animation) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                        child: Text(
                                          _currentLoadingSubtitle,
                                          key: ValueKey(
                                            _currentLoadingSubtitle,
                                          ),
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: TWColors.slate.shade900
                                                .withAlpha(180),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }

  Column _picturePlaceholder() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 16.h,
      children: [
        SvgPicture.asset(
          'assets/icons/picture-plus.svg',
          colorFilter: ColorFilter.mode(
            TWColors.slate.shade400,
            BlendMode.srcIn,
          ),
        ),
        Text(
          context.t.pictureInputPlaceholder,
          style: TextStyle(fontSize: 18.sp, color: TWColors.slate.shade500),
        ),
      ],
    );
  }
}

class SparklesPainter extends CustomPainter {
  final Animation<double> animation;
  final math.Random _random = math.Random(42);
  final List<Sparkle> _sparkles = [];

  SparklesPainter({required this.animation}) {
    // Générer 50 paillettes avec des positions et timings aléatoires
    if (_sparkles.isEmpty) {
      for (int i = 0; i < 50; i++) {
        _sparkles.add(Sparkle(seed: i, random: _random));
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (var sparkle in _sparkles) {
      final opacity = sparkle.getOpacity(animation.value);
      if (opacity > 0) {
        final position = sparkle.getPosition(size);
        final sparkleSize = sparkle.size;

        // Dessiner un cercle parfait avec effet de glow
        _drawSparkle(canvas, position, sparkleSize, opacity);
      }
    }
  }

  void _drawSparkle(Canvas canvas, Offset center, double size, double opacity) {
    // Dessiner plusieurs cercles concentriques pour créer un effet de glow
    // Halo externe (très transparent)
    final glowPaint1 = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.3)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, size * 0.8);
    canvas.drawCircle(center, size * 1.5, glowPaint1);

    // Halo moyen
    final glowPaint2 = Paint()
      ..color = Colors.white.withOpacity(opacity * 0.6)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, size * 0.4);
    canvas.drawCircle(center, size * 0.8, glowPaint2);

    // Cercle principal brillant
    final mainPaint = Paint()
      ..color = Colors.white.withOpacity(opacity)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, size * 0.5, mainPaint);
  }

  @override
  bool shouldRepaint(SparklesPainter oldDelegate) => true;
}

class Sparkle {
  final double x;
  final double y;
  final double size;
  final double delay;
  final double duration;

  Sparkle({required int seed, required math.Random random})
    : x = random.nextDouble(),
      y = random.nextDouble(),
      size = 2.5 + random.nextDouble() * 2,
      delay = random.nextDouble(),
      duration = 0.3 + random.nextDouble() * 0.4;

  Offset getPosition(Size size) {
    return Offset(x * size.width, y * size.height);
  }

  double getOpacity(double animationValue) {
    // Calculer la progression dans le cycle de cette paillette
    final adjustedValue = (animationValue + delay) % 1.0;

    if (adjustedValue < duration / 2) {
      // Fade in
      return (adjustedValue / (duration / 2)).clamp(0.0, 1.0);
    } else if (adjustedValue < duration) {
      // Fade out
      return ((duration - adjustedValue) / (duration / 2)).clamp(0.0, 1.0);
    } else {
      return 0.0;
    }
  }
}

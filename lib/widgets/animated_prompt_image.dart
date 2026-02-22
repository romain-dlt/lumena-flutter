import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_tailwind_colors/flutter_tailwind_colors.dart';
import 'package:lumena_ai/models/models.dart';
import 'package:lumena_ai/pages/editor_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lumena_ai/widgets/widgets.dart';
import 'package:lumena_ai/services/animation_sync_service.dart';

class AnimatedPromptImage extends StatefulWidget {
  final PromptModel prompt;

  const AnimatedPromptImage({super.key, required this.prompt});

  @override
  State<AnimatedPromptImage> createState() => _AnimatedPromptImageState();
}

class _AnimatedPromptImageState extends State<AnimatedPromptImage>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  final _syncService = AnimationSyncService();
  double _currentPosition = 0.0;
  bool _isBeforeImageLoaded = false;
  bool _isAfterImageLoaded = false;

  @override
  void initState() {
    super.initState();
    // Utilise un Ticker pour se synchroniser avec le temps absolu
    _ticker = createTicker((elapsed) {
      setState(() {
        _currentPosition = _syncService.getLightBarPosition();
      });
    })..start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = constraints.maxHeight;
        final bool isFullyLoaded = _isBeforeImageLoaded && _isAfterImageLoaded;

        return TappableWrapper(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => EditPage(
                  initialPrompt: widget.prompt.text,
                  initialImage: widget.prompt.beforeImagePath,
                ),
              ),
            );
          },
          child: Container(
            width: 190.w,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Stack(
              children: [
                // Image BEFORE (fond)
                Positioned.fill(
                  child: Image.network(
                    widget.prompt.beforeImagePath,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted && !_isBeforeImageLoaded) {
                            setState(() {
                              _isBeforeImageLoaded = true;
                            });
                          }
                        });
                        return child;
                      }
                      return Container(color: TWColors.slate.shade300);
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: TWColors.slate.shade300,
                        child: Center(
                          child: Icon(
                            Icons.error_outline,
                            color: TWColors.slate.shade500,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Image AFTER (révélée progressivement)
                Positioned.fill(
                  child: ClipRect(
                    clipper: _RevealClipper(_currentPosition),
                    child: Image.network(
                      widget.prompt.afterImagePath,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            if (mounted && !_isAfterImageLoaded) {
                              setState(() {
                                _isAfterImageLoaded = true;
                              });
                            }
                          });
                          return child;
                        }
                        return Container(color: TWColors.slate.shade300);
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: TWColors.slate.shade300,
                          child: Center(
                            child: Icon(
                              Icons.error_outline,
                              color: TWColors.slate.shade500,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Barre lumineuse
                if (isFullyLoaded)
                  Positioned(
                    top: _currentPosition * height - 2,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            TWColors.white.withAlpha(150),
                            TWColors.white,
                            TWColors.white.withAlpha(150),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: TWColors.white.withAlpha(190),
                            blurRadius: 10.r,
                            spreadRadius: 2.r,
                          ),
                        ],
                      ),
                    ),
                  ),
                // Gradient et texte
                if (isFullyLoaded)
                  Positioned.fill(
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            TWColors.black.withAlpha(130),
                            TWColors.transparent,
                          ],
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          widget.prompt.label,
                          style: TextStyle(
                            color: TWColors.white,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                // Skeleton loader par-dessus pendant le chargement
                if (!isFullyLoaded)
                  Positioned.fill(
                    child: SkeletonLoader(
                      width: 190.w,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RevealClipper extends CustomClipper<Rect> {
  final double progress;

  _RevealClipper(this.progress);

  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width, size.height * progress);
  }

  @override
  bool shouldReclip(_RevealClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}

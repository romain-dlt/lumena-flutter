import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TappableWrapper extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool enabled;
  final HapticFeedbackType hapticFeedbackType;
  final double scaleOnTap;
  final Duration animationDuration;

  const TappableWrapper({
    super.key,
    required this.child,
    this.onTap,
    this.enabled = true,
    this.hapticFeedbackType = HapticFeedbackType.light,
    this.scaleOnTap = 0.95,
    this.animationDuration = const Duration(milliseconds: 100),
  });

  @override
  State<TappableWrapper> createState() => _TappableWrapperState();
}

class _TappableWrapperState extends State<TappableWrapper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: widget.scaleOnTap,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.enabled || widget.onTap == null) return;
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.enabled || widget.onTap == null) return;
    _controller.reverse();
  }

  void _handleTapCancel() {
    if (!widget.enabled || widget.onTap == null) return;
    _controller.reverse();
  }

  void _handleTap() {
    if (!widget.enabled || widget.onTap == null) return;

    // Retour haptique
    switch (widget.hapticFeedbackType) {
      case HapticFeedbackType.light:
        HapticFeedback.lightImpact();
        break;
      case HapticFeedbackType.medium:
        HapticFeedback.mediumImpact();
        break;
      case HapticFeedbackType.heavy:
        HapticFeedback.heavyImpact();
        break;
      case HapticFeedbackType.selection:
        HapticFeedback.selectionClick();
        break;
      case HapticFeedbackType.vibrate:
        HapticFeedback.vibrate();
        break;
    }

    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: _handleTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(scale: _scaleAnimation.value, child: child);
        },
        child: widget.child,
      ),
    );
  }
}

enum HapticFeedbackType { light, medium, heavy, selection, vibrate }

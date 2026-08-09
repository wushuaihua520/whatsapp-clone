import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/constants.dart';

/// A lightweight approximation of the translucent material used by iOS 26.
class GlassSurface extends StatelessWidget {
  const GlassSurface({
    super.key,
    required this.child,
    this.borderRadius = 28,
    this.blur = 24,
    this.opacity = 0.72,
    this.padding,
    this.boxShadow = true,
  });

  final Widget child;
  final double borderRadius;
  final double blur;
  final double opacity;
  final EdgeInsetsGeometry? padding;
  final bool boxShadow;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: boxShadow
            ? const [
                BoxShadow(
                  color: Color(0x1A10233D),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
                BoxShadow(
                  color: Color(0x0FFFFFFF),
                  blurRadius: 3,
                  offset: Offset(0, -1),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white
                      .withOpacity(opacity + 0.12 > 1 ? 1 : opacity + 0.12),
                  Colors.white.withOpacity(opacity),
                ],
              ),
              borderRadius: radius,
              border: Border.all(
                color: Colors.white.withOpacity(0.78),
                width: 0.8,
              ),
            ),
            child: Padding(
              padding: padding ?? EdgeInsets.zero,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class GlassCircleButton extends StatelessWidget {
  const GlassCircleButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.size = 42,
    this.iconColor = iosBlue,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? tooltip;
  final double size;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final button = GlassSurface(
      borderRadius: size / 2,
      blur: 18,
      opacity: 0.66,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          child: SizedBox(
            width: size,
            height: size,
            child: Icon(icon, color: iconColor, size: 21),
          ),
        ),
      ),
    );

    if (tooltip == null) {
      return button;
    }
    return Tooltip(message: tooltip!, child: button);
  }
}

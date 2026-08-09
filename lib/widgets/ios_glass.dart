import 'dart:ui';

import 'package:flutter/material.dart';

/// iOS-style frosted glass surface (UIBlurEffect light).
class IosGlass extends StatelessWidget {
  const IosGlass({
    super.key,
    required this.child,
    this.borderRadius,
    this.sigma = 28,
    this.tint = const Color(0xCCF9F9F9),
    this.border,
    this.shadows,
  });

  final Widget child;
  final BorderRadius? borderRadius;
  final double sigma;
  final Color tint;
  final BoxBorder? border;
  final List<BoxShadow>? shadows;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius;

    Widget blurred = BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: tint,
          borderRadius: radius,
          border: border,
        ),
        child: child,
      ),
    );

    if (radius != null) {
      blurred = ClipRRect(borderRadius: radius, child: blurred);
    } else {
      blurred = ClipRect(child: blurred);
    }

    // Keep shadows outside the clip so glass still casts soft depth.
    if (shadows == null || shadows!.isEmpty) return blurred;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: shadows,
      ),
      child: blurred,
    );
  }
}

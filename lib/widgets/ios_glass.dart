import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// iOS-style frosted glass.
///
/// On real iOS/Android, [BackdropFilter] blurs live content behind the bar.
/// On Flutter Web (and headless captures) BackdropFilter is often a no-op,
/// so we also paint an optional [frostImage] (e.g. chat wallpaper) that is
/// blurred in-place — that makes the “see-through” effect visible everywhere.
class IosGlass extends StatelessWidget {
  const IosGlass({
    super.key,
    required this.child,
    this.borderRadius,
    this.sigma = 28,
    this.tint = const Color(0x99F7F7F7),
    this.border,
    this.shadows,
    this.frostImage,
    this.frostFit = BoxFit.cover,
    this.frostAlignment = Alignment.topCenter,
  });

  final Widget child;
  final BorderRadius? borderRadius;
  final double sigma;
  final Color tint;
  final BoxBorder? border;
  final List<BoxShadow>? shadows;

  /// Optional static layer (wallpaper) used when live backdrop blur is weak.
  final ImageProvider? frostImage;
  final BoxFit frostFit;
  final Alignment frostAlignment;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius;

    Widget surface = Stack(
      fit: StackFit.passthrough,
      children: [
        if (frostImage != null)
          Positioned.fill(
            child: IgnorePointer(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: sigma,
                  sigmaY: sigma,
                  tileMode: TileMode.clamp,
                ),
                child: Transform.scale(
                  scale: 1.08,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: frostImage!,
                        fit: frostFit,
                        alignment: frostAlignment,
                        colorFilter: ColorFilter.mode(
                          Colors.white.withValues(alpha: 0.15),
                          BlendMode.lighten,
                        ),
                      ),
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ),
          ),
        // Live blur of widgets painted behind this glass (works on device /
        // desktop Skia; often invisible on Flutter Web screenshots).
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: const ColoredBox(color: Colors.transparent),
          ),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: tint,
              borderRadius: radius,
              border: border,
            ),
          ),
        ),
        child,
      ],
    );

    if (radius != null) {
      surface = ClipRRect(borderRadius: radius, child: surface);
    } else {
      surface = ClipRect(child: surface);
    }

    if (shadows == null || shadows!.isEmpty) return surface;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: shadows,
      ),
      child: surface,
    );
  }
}

/// Stronger frost tuned for chat chrome over doodle wallpaper.
class ChatGlassBar extends StatelessWidget {
  const ChatGlassBar({
    super.key,
    required this.child,
    this.topBorder = false,
    this.bottomBorder = false,
    this.frostAlignment = Alignment.topCenter,
  });

  final Widget child;
  final bool topBorder;
  final bool bottomBorder;
  final Alignment frostAlignment;

  @override
  Widget build(BuildContext context) {
    // More transparent on web so wallpaper read-through is obvious in shots.
    final tint = kIsWeb
        ? const Color(0x66F5F5F7)
        : const Color(0x8FF5F5F7);

    return IosGlass(
      sigma: kIsWeb ? 22 : 36,
      tint: tint,
      frostImage: const AssetImage('assets/images/default-wallpaper.png'),
      frostAlignment: frostAlignment,
      border: Border(
        top: topBorder
            ? BorderSide(
                color: Colors.white.withValues(alpha: 0.55),
                width: 0.6,
              )
            : BorderSide.none,
        bottom: bottomBorder
            ? BorderSide(
                color: Colors.white.withValues(alpha: 0.55),
                width: 0.6,
              )
            : BorderSide.none,
      ),
      child: child,
    );
  }
}

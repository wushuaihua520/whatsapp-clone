import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

/// Logical size of an iPhone 16 / 15 Pro portrait display.
const Size kIphoneLogicalSize = Size(393, 852);

/// Typical Dynamic Island / status-bar inset on recent iPhones.
const double kIphoneStatusInset = 59;

/// Home-indicator safe area on recent iPhones.
const double kIphoneHomeInset = 34;

/// Wraps the app so desktop/web previews feel like an Apple phone.
class IphoneExperience extends StatelessWidget {
  const IphoneExperience({
    super.key,
    required this.child,
    this.forceFrame,
  });

  final Widget child;
  final bool? forceFrame;

  static bool shouldShowFrame(Size viewport, {bool? forceFrame}) {
    if (forceFrame != null) return forceFrame;
    if (!kIsWeb) return false;
    final looksLikeHandset =
        viewport.shortestSide < 500 && viewport.width <= 500;
    if (looksLikeHandset) return false;
    return viewport.width >= kIphoneLogicalSize.width + 48;
  }

  @override
  Widget build(BuildContext context) {
    final host = MediaQuery.of(context);
    final viewport = host.size;
    final showFrame = shouldShowFrame(viewport, forceFrame: forceFrame);

    if (!showFrame) {
      if (!kIsWeb && forceFrame != true) return child;
      return _IphoneMetrics(host: host, size: viewport, child: child);
    }

    return ColoredBox(
      color: const Color(0xFF0B0B0D),
      child: LayoutBuilder(
        builder: (context, constraints) {
          const bezel = 14.0;
          final phoneWidth = kIphoneLogicalSize.width + bezel * 2;
          final phoneHeight = kIphoneLogicalSize.height + bezel * 2;
          final maxW = math.max(constraints.maxWidth - 40, 1.0);
          final maxH = math.max(constraints.maxHeight - 40, 1.0);
          final scale = math.min(maxW / phoneWidth, maxH / phoneHeight);

          return Stack(
            fit: StackFit.expand,
            children: [
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(0, -0.15),
                    radius: 1.15,
                    colors: [
                      Color(0xFF2A2A30),
                      Color(0xFF121214),
                      Color(0xFF070708),
                    ],
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: phoneWidth * scale,
                  height: phoneHeight * scale,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: _IphoneHardware(
                      screen: _IphoneMetrics(
                        host: host,
                        size: kIphoneLogicalSize,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            child,
                            const IgnorePointer(child: _StatusBarOverlay()),
                            const IgnorePointer(child: _HomeIndicator()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _IphoneMetrics extends StatelessWidget {
  const _IphoneMetrics({
    required this.host,
    required this.size,
    required this.child,
  });

  final MediaQueryData host;
  final Size size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final top = math.max(host.padding.top, kIphoneStatusInset);
    final bottom = math.max(host.padding.bottom, kIphoneHomeInset);
    final padding = EdgeInsets.only(top: top, bottom: bottom);

    return MediaQuery(
      data: host.copyWith(
        size: size,
        padding: padding,
        viewPadding: padding,
        viewInsets: EdgeInsets.zero,
      ),
      child: child,
    );
  }
}

class _IphoneHardware extends StatelessWidget {
  const _IphoneHardware({required this.screen});

  final Widget screen;

  @override
  Widget build(BuildContext context) {
    const bezel = 14.0;
    const radius = 55.0;
    final width = kIphoneLogicalSize.width + bezel * 2;
    final height = kIphoneLogicalSize.height + bezel * 2;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF5C5C63),
                    Color(0xFF1C1C1F),
                    Color(0xFF3A3A40),
                    Color(0xFF111114),
                  ],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x99000000),
                    blurRadius: 48,
                    offset: Offset(0, 28),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: bezel,
            top: bezel,
            width: kIphoneLogicalSize.width,
            height: kIphoneLogicalSize.height,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius - bezel + 2),
              child: ColoredBox(
                color: CupertinoColors.black,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    screen,
                    const Positioned(
                      top: 11,
                      left: 0,
                      right: 0,
                      child: Center(child: _DynamicIsland()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DynamicIsland extends StatelessWidget {
  const _DynamicIsland();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 126,
      height: 37,
      decoration: BoxDecoration(
        color: CupertinoColors.black,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }
}

class _StatusBarOverlay extends StatelessWidget {
  const _StatusBarOverlay();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: kIphoneStatusInset,
        child: Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 22, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 54,
                child: Text(
                  '9:41',
                  style: TextStyle(
                    color: CupertinoColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                    height: 1,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              Spacer(),
              Icon(CupertinoIcons.chart_bar_fill, size: 14),
              SizedBox(width: 5),
              Icon(CupertinoIcons.wifi, size: 14),
              SizedBox(width: 5),
              Icon(CupertinoIcons.battery_100, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}

class _HomeIndicator extends StatelessWidget {
  const _HomeIndicator();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Container(
          width: 134,
          height: 5,
          decoration: BoxDecoration(
            color: CupertinoColors.black.withOpacity(0.88),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}

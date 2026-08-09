import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Logical size of an iPhone 16 / 15 Pro portrait display.
const Size kIphoneLogicalSize = Size(393, 852);

/// Typical Dynamic Island / status-bar inset on recent iPhones.
const double kIphoneStatusInset = 59;

/// Home-indicator safe area on recent iPhones.
const double kIphoneHomeInset = 34;

/// Wraps the app so desktop/web previews feel like an Apple phone:
/// titanium bezel, Dynamic Island, status icons, home indicator, and
/// iPhone-accurate [MediaQuery] padding.
class IphoneExperience extends StatelessWidget {
  const IphoneExperience({super.key, required this.child});

  final Widget child;

  static bool shouldShowFrame(Size viewport) {
    if (!kIsWeb && defaultTargetPlatform != TargetPlatform.macOS) {
      // Keep native mobile / test surfaces fullscreen.
      if (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android) {
        return false;
      }
    }
    // Show the phone chrome whenever there is room around the logical screen.
    return viewport.width >= kIphoneLogicalSize.width + 72 &&
        viewport.height >= kIphoneLogicalSize.height + 72;
  }

  @override
  Widget build(BuildContext context) {
    final host = MediaQuery.of(context);
    final viewport = host.size;
    final showFrame = shouldShowFrame(viewport);

    // Widget tests / native phones keep the host metrics.
    // Web on a real iPhone stays fullscreen but gains Apple-like insets
    // when the browser reports none.
    if (!showFrame) {
      if (!kIsWeb) return child;
      return _withIphoneMetrics(host: host, size: viewport, child: child);
    }

    return ColoredBox(
      color: const Color(0xFF0B0B0D),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const _DeskAtmosphere(),
          Center(
            child: FittedBox(
              fit: BoxFit.contain,
              child: Padding(
                padding: const EdgeInsets.all(28),
                child: _IphoneHardware(
                  child: SizedBox(
                    width: kIphoneLogicalSize.width,
                    height: kIphoneLogicalSize.height,
                    child: _withIphoneMetrics(
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
          ),
        ],
      ),
    );
  }

  Widget _withIphoneMetrics({
    required MediaQueryData host,
    required Size size,
    required Widget child,
  }) {
    final top = math.max(host.padding.top, kIphoneStatusInset);
    final bottom = math.max(host.padding.bottom, kIphoneHomeInset);
    final padding = EdgeInsets.only(top: top, bottom: bottom);

    return MediaQuery(
      data: host.copyWith(
        size: size,
        padding: padding,
        viewPadding: padding,
        viewInsets: EdgeInsets.zero,
        devicePixelRatio: math.max(host.devicePixelRatio, 3),
      ),
      child: child,
    );
  }
}

class _DeskAtmosphere extends StatelessWidget {
  const _DeskAtmosphere();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(0, -0.15),
          radius: 1.15,
          colors: [
            Color(0xFF2A2A30),
            Color(0xFF121214),
            Color(0xFF070708),
          ],
          stops: [0, 0.55, 1],
        ),
      ),
      child: SizedBox.expand(),
    );
  }
}

class _IphoneHardware extends StatelessWidget {
  const _IphoneHardware({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    const bezel = 14.0;
    const radius = 55.0;

    return Container(
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
          stops: [0, 0.35, 0.7, 1],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x99000000),
            blurRadius: 48,
            offset: Offset(0, 28),
          ),
          BoxShadow(
            color: Color(0x33FFFFFF),
            blurRadius: 1,
            offset: Offset(0, -0.5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(bezel),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Side buttons
          const Positioned(left: -bezel - 2, top: 148, child: _SideButton(height: 36)),
          const Positioned(left: -bezel - 2, top: 208, child: _SideButton(height: 62)),
          const Positioned(left: -bezel - 2, top: 286, child: _SideButton(height: 62)),
          const Positioned(right: -bezel - 2, top: 230, child: _SideButton(height: 96)),
          ClipRRect(
            borderRadius: BorderRadius.circular(radius - bezel + 2),
            child: ColoredBox(
              color: Colors.black,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  child,
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
        ],
      ),
    );
  }
}

class _SideButton extends StatelessWidget {
  const _SideButton({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 4,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C30),
        borderRadius: BorderRadius.circular(2),
        border: Border.all(color: const Color(0xFF4A4A50), width: 0.5),
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
        color: Colors.black,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x66000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 14),
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF1B3A5F).withOpacity(0.9),
                  const Color(0xFF0A1624),
                ],
              ),
              border: Border.all(color: const Color(0xFF111820), width: 1),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatusBarOverlay extends StatelessWidget {
  const _StatusBarOverlay();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: SizedBox(
        height: kIphoneStatusInset,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 16, 22, 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                width: 54,
                child: Text(
                  '9:41',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.3,
                    height: 1,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
              const Spacer(),
              Icon(Icons.signal_cellular_alt, size: 15, color: Colors.black.withOpacity(0.92)),
              const SizedBox(width: 5),
              Icon(Icons.wifi, size: 15, color: Colors.black.withOpacity(0.92)),
              const SizedBox(width: 5),
              const _BatteryPill(),
            ],
          ),
        ),
      ),
    );
  }
}

class _BatteryPill extends StatelessWidget {
  const _BatteryPill();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 27,
      height: 13,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 1,
            child: Container(
              width: 24,
              height: 11,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.5),
                border: Border.all(color: Colors.black.withOpacity(0.45), width: 1.1),
              ),
              padding: const EdgeInsets.all(1.5),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 16,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.92),
                    borderRadius: BorderRadius.circular(1.8),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 4,
            child: Container(
              width: 1.6,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ),
        ],
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
            color: Colors.black.withOpacity(0.88),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}

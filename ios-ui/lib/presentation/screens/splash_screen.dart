import 'package:flutter/material.dart';

import '../core/routes/routes_name.dart';
import '../../utils/k_images.dart';
import '../../utils/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(milliseconds: 1500)).then((_) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, RouteNames.welcome);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 88,
                height: 88,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0FFF4),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: actionGreen.withOpacity(0.12),
                      blurRadius: 24,
                      spreadRadius: 6,
                    ),
                  ],
                ),
                child: Image.asset(KImages.logo),
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 32,
              child: Column(
                children: [
                  Text(
                    'from',
                    style: TextStyle(
                      color: subTitleTextColor,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.all_inclusive_rounded,
                        color: primaryColor,
                        size: 21,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'Meta',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

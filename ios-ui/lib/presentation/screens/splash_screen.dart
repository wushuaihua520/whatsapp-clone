import 'package:flutter/cupertino.dart';

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
    return CupertinoPageScaffold(
      backgroundColor: scaffoldBgColor,
      child: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                width: 88,
                height: 88,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color(0xFFF0FFF4),
                  shape: BoxShape.circle,
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
                      color: CupertinoColors.systemGrey,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 5),
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
            ),
          ],
        ),
      ),
    );
  }
}

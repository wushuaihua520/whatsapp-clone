import 'package:flutter/cupertino.dart';

import 'package:whatsapp_ios_ui/presentation/core/routes/routes_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/strings.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: scaffoldBgColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 18),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    KImages.whatsappWelcome,
                    width: 286,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                KStrings.welcomeTitle,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 16),
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: KStrings.read,
                  style: const TextStyle(
                    color: CupertinoColors.systemGrey,
                    fontSize: 13,
                    height: 1.45,
                  ),
                  children: [
                    TextSpan(
                      text: KStrings.privacyPolicy,
                      style: const TextStyle(color: Color(0xFF027EB5)),
                    ),
                    TextSpan(text: KStrings.tapAgree),
                    TextSpan(
                      text: KStrings.termsService,
                      style: const TextStyle(color: Color(0xFF027EB5)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              CupertinoButton(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                color: searchFieldColor,
                borderRadius: BorderRadius.circular(24),
                onPressed: () => _openLanguageSheet(context),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(CupertinoIcons.globe, color: primaryColor, size: 20),
                    SizedBox(width: 10),
                    Text(
                      'English',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      CupertinoIcons.chevron_down,
                      color: primaryColor,
                      size: 16,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(24),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteNames.auth);
                  },
                  child: Text(
                    KStrings.agreeContinue,
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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

  void _openLanguageSheet(BuildContext context) {
    const languages = [
      'English',
      'Español',
      'हिन्दी',
      'Português',
      'العربية',
      '中文',
    ];

    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text('App language'),
          actions: [
            for (final language in languages)
              CupertinoActionSheetAction(
                onPressed: () => Navigator.pop(context),
                child: Text(language),
              ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
        );
      },
    );
  }
}

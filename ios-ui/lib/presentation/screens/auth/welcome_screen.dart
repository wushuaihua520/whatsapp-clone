import 'package:flutter/material.dart';

import 'package:whatsapp_ios_ui/presentation/core/routes/routes_name.dart';
import '../../../utils/constants.dart';
import '../../../utils/k_images.dart';
import '../../../utils/strings.dart';
import '../../../widgets/custom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                    color: subTitleTextColor,
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
              Material(
                color: searchFieldColor,
                borderRadius: BorderRadius.circular(24),
                clipBehavior: Clip.antiAlias,
                child: InkWell(
                  onTap: () => openBottomSheet(context),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.language_rounded,
                          color: primaryColor,
                          size: 21,
                        ),
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
                          Icons.expand_more_rounded,
                          color: primaryColor,
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: KStrings.agreeContinue,
                height: 48,
                press: () {
                  Navigator.pushNamed(context, RouteNames.auth);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openBottomSheet(BuildContext context) {
    const languages = [
      'English',
      'Español',
      'हिन्दी',
      'Português',
      'العربية',
      '中文',
    ];

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      tooltip: 'Close',
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close_rounded),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'App language',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ...languages.map(
                  (language) => ListTile(
                    onTap: () => Navigator.pop(context),
                    leading: Icon(
                      language == 'English'
                          ? Icons.radio_button_checked_rounded
                          : Icons.radio_button_off_rounded,
                      color: language == 'English'
                          ? primaryColor
                          : subTitleTextColor,
                    ),
                    title: Text(
                      language,
                      style: const TextStyle(fontSize: 16),
                    ),
                    subtitle: language == 'English'
                        ? const Text('Device language')
                        : null,
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

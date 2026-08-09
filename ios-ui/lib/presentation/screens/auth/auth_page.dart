import 'package:flutter/cupertino.dart';

import '../../../utils/constants.dart';
import '../../../utils/strings.dart';
import '../../core/routes/routes_name.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          KStrings.enterPhoneTitle,
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          minSize: 0,
          onPressed: () {},
          child: const Icon(CupertinoIcons.ellipsis, color: textColor),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 18),
          child: Column(
            children: [
              const Text(
                'WhatsApp will need to verify your phone number.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 28),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'United States',
                      style: TextStyle(color: iosBlue, fontSize: 16),
                    ),
                    Icon(CupertinoIcons.chevron_down, size: 16, color: iosBlue),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Row(
                children: [
                  SizedBox(
                    width: 72,
                    child: CupertinoTextField(
                      placeholder: '+1',
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: CupertinoTextField(
                      placeholder: 'phone number',
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(24),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      RouteNames.mainScreen,
                      (_) => false,
                    );
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: CupertinoColors.white,
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
}

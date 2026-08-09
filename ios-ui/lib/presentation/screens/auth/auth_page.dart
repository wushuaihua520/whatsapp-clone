import 'package:flutter/material.dart';

import '../../../widgets/custom_button.dart';
import '../../../utils/constants.dart';
import '../../../utils/strings.dart';
import '../../core/routes/routes_name.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          KStrings.enterPhoneTitle,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: primaryColor,
          ),
        ),
        actions: [
          PopupMenuButton<String>(
              tooltip: 'More options',
              icon: const Icon(Icons.more_vert_rounded, color: textColor),
              itemBuilder: (context) {
                return const <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'companion',
                    child: Text('Link as companion device'),
                  ),
                  PopupMenuItem<String>(
                    value: 'help',
                    child: Text('Help'),
                  ),
                ];
              }),
          const SizedBox(width: 4),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 12, 28, 20),
          child: Column(
            children: [
              Text.rich(
                textAlign: TextAlign.center,
                TextSpan(
                  text: KStrings.verifyAccountText,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.45,
                    color: textColor,
                  ),
                  children: [
                    TextSpan(
                      text: KStrings.myNumber,
                      style: const TextStyle(color: Color(0xFF027EB5)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 310),
                child: DropdownButtonFormField<String>(
                  value: 'Bangladesh',
                  isExpanded: true,
                  alignment: Alignment.center,
                  icon: const Icon(
                    Icons.arrow_drop_down_rounded,
                    color: primaryColor,
                  ),
                  decoration: const InputDecoration(
                    filled: false,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 10,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 1.5),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Bangladesh',
                      child: Center(child: Text('Bangladesh')),
                    ),
                    DropdownMenuItem(
                      value: 'United States',
                      child: Center(child: Text('United States')),
                    ),
                    DropdownMenuItem(
                      value: 'United Kingdom',
                      child: Center(child: Text('United Kingdom')),
                    ),
                  ],
                  onChanged: (_) {},
                ),
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 310),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 74,
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: false,
                          hintText: '+880',
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 1.5),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.phone,
                        autofocus: false,
                        decoration: InputDecoration(
                          filled: false,
                          hintText: KStrings.phontHint,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 1.5),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryColor, width: 2),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Text(
                KStrings.carrierCharge,
                style: const TextStyle(
                  color: subTitleTextColor,
                  fontSize: 12,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 96,
                child: CustomButton(
                  text: 'Next',
                  textSize: 15,
                  height: 46,
                  press: () {
                    Navigator.pushReplacementNamed(
                      context,
                      RouteNames.mainScreen,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

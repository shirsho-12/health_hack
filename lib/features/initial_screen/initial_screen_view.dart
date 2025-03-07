import 'dart:developer' as devtools show log;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../localization/localize.dart';

abstract class InitialScreenViewModelProtocol extends ChangeNotifier {}

class InitialScreenView extends StatelessWidget {
  final InitialScreenViewModelProtocol viewModel;

  const InitialScreenView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = Localize.instance.l10n;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.logo_dev_rounded, size: 100),
          Text(l10n.appTitle, textAlign: TextAlign.center),
          ElevatedButton(
            onPressed: () {
              // Handle login button press
            },
            child: Text(l10n.login),
          ),
          const SizedBox(height: 20),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: l10n.newUserHint,
              style: DefaultTextStyle.of(context).style,
              children: [
                TextSpan(
                  text: l10n.signUpHere,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          // Handle sign up tap
                          devtools.log('Sign up tapped');
                        },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

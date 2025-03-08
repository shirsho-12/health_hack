import 'dart:developer' as devtools show log;
import 'dart:math';
import 'package:country_flags/country_flags.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_ui.dart';
import '../../localization/localization_bloc.dart';
import '../../localization/localize.dart';

abstract class InitialScreenViewModelProtocol extends ChangeNotifier {}

class InitialScreenView extends StatelessWidget {
  final InitialScreenViewModelProtocol viewModel;

  const InitialScreenView({required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = Localize.instance.l10n;
    final double buttonWidth = min(
      MediaQuery.of(context).size.width * 0.3,
      200,
    );
    final double buttonHeight = min(
      MediaQuery.of(context).size.height * 0.08,
      60,
    );
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                PopupMenuButton<String>(
                  icon: const Icon(Icons.language),
                  onSelected: (value) async {
                    // Handle language selection
                    BlocProvider.of<LocalizationBloc>(
                      context,
                    ).add(LoadLocalization(Locale(value)));
                  },
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'en',
                        child: Row(
                          children: [
                            CountryFlag.fromLanguageCode('en'),
                            const SizedBox(width: 8),
                            Text(Localize.instance.l10n.english),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'zh',
                        child: Row(
                          children: [
                            CountryFlag.fromLanguageCode('zh-cn'),
                            const SizedBox(width: 8),
                            Text(Localize.instance.l10n.chinese),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),

            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logo_dev_rounded, size: 100),
                  Text(
                    l10n.appTitle,
                    textAlign: TextAlign.center,
                    style: HHackTextStyle.headline1,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Handle login button press
                      devtools.log('Login button pressed');
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(buttonWidth, buttonHeight),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                    child: Text(l10n.login, style: HHackTextStyle.button),
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: '${l10n.newUserHint} ',
                      style: HHackTextStyle.bodyText1,
                      children: [
                        TextSpan(
                          text: l10n.signUpHere,
                          style: HHackTextStyle.bodyText1.copyWith(
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
            ),
          ),
        );
      },
    );
  }
}

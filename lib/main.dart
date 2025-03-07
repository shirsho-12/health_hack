import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/localization.dart';

import 'app_ui.dart';
import 'localization/localize.dart';
import 'router/mobile_router.dart';
import 'support/utils/service_locator/service_locator.dart';

void main() {
  initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: HHackTheme.small,
      debugShowCheckedModeBanner: false,
      routerConfig: MobileRouter.router,
      supportedLocales: Localization.supportedLocales,
      localizationsDelegates: Localization.localizationsDelegates,
      onGenerateTitle: (context) => Localize.instance.of(context).appTitle,
    );
  }
}

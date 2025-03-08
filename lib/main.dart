import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_ui.dart';
import 'localization/localization_bloc.dart';
import 'localization/localize.dart';
import 'router/mobile_router.dart';
import 'support/utils/service_locator/service_locator.dart';

void main() async {
  initializeDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance().then(
    (prefs) => ServiceLocator.registerSingleton<SharedPreferences>(prefs),
  );
  runApp(
    BlocProvider(
      create:
          (context) => LocalizationBloc()..add(const LoadSavedLocalization()),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // get the locale from the service locator
  // if it is not available, use the default locale
  // and set the locale to the app
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
        return MaterialApp.router(
          theme: HHackTheme.small,
          debugShowCheckedModeBanner: false,
          routerConfig: MobileRouter.router,
          supportedLocales: Localization.supportedLocales,
          localizationsDelegates: Localization.localizationsDelegates,
          locale: state.locale,
          onGenerateTitle: (context) => Localize.instance.of(context).appTitle,
        );
      },
    );
  }
}

class BlankScreen extends StatelessWidget {
  const BlankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Push a new screen on top automatically
    return const Scaffold(body: Center(child: Text('Blank Screen')));
  }
}

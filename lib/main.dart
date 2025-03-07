import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_ui.dart';
import 'localization/localize.dart';
import 'router/mobile_router.dart';
import 'support/app_language.dart';
import 'support/utils/service_locator/service_locator.dart';

void main() async {
  initializeDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({required this.prefs, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AppLanguage>(create: (_) => AppLanguage(prefs))],
      child: BlocBuilder<AppLanguage, LocaleState>(
        buildWhen:
            (previous, current) =>
                previous.prefs.getString('locale') !=
                current.prefs.getString('locale'),
        builder: (context, state) {
          return MaterialApp.router(
            theme: HHackTheme.small,
            debugShowCheckedModeBanner: false,
            routerConfig: MobileRouter.router,
            supportedLocales: Localization.supportedLocales,
            localizationsDelegates: Localization.localizationsDelegates,
            locale: Locale(
              state.prefs.getString('locale') ?? 'en',
            ), // <--- Updated
            onGenerateTitle:
                (context) => Localize.instance.of(context).appTitle,
          );
        },
      ),
    );
  }
}

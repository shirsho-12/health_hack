part of 'app_language.dart';

@immutable
abstract class LocaleState {
  final SharedPreferences prefs;
  const LocaleState(this.prefs);
}

class SelectedLocale extends LocaleState {
  const SelectedLocale(super.prefs);
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'localization_event.dart';
part 'localization_state.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  LocalizationBloc() : super(LocalizationState.initial()) {
    on<LoadLocalization>((event, emit) {
      if (event.locale != state.locale) {
        saveLocale(event.locale);
        emit(LocalizationState(event.locale));
      }
    });
    on<LoadSavedLocalization>((event, emit) async {
      final locale = await getLocale();
      emit(LocalizationState(locale));
    });
  }

  Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);
  }

  Future<Locale> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final locale = prefs.getString('locale');
    return Locale(locale ?? 'en');
  }
}

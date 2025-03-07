import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'locale_state.dart';

class AppLanguage extends Cubit<LocaleState> {
  AppLanguage(SharedPreferences prefs) : super(SelectedLocale(prefs));

  Future<void> changeLanguage(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', locale.languageCode);
    emit(SelectedLocale(prefs));
  }
}

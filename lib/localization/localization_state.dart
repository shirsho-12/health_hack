part of 'localization_bloc.dart';

class LocalizationState extends Equatable {
  final Locale locale;
  const LocalizationState(this.locale);

  factory LocalizationState.initial() {
    return const LocalizationState(Locale('en'));
  }

  LocalizationState copywith({Locale? locale}) {
    return LocalizationState(locale ?? this.locale);
  }

  @override
  List<Object> get props => [locale];
}

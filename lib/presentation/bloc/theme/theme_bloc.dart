import 'package:bubble/domain/preferences/repository/preferences_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bubble/config/constants/constants.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'theme_event.dart';
part 'theme_state.dart';

@injectable
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final PreferencesRepository preferencesRepository;
  ThemeBloc(this.preferencesRepository) : super(const ThemeState()) {
    on<LoadTheme>(_loadTheme);
    on<ChangeTheme>(_changeTheme);
    on<MarkAsFirstLaunched>(_markAsFirstLaunched);
  }

  void _loadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    emit(ThemeState(
      isDarkMode: await _getBoolValue(PreferenceConstants.isDarkMode),
      isFirstLaunch: await _getBoolValue(PreferenceConstants.isFirstLaunch),
    ));
  }

  void _changeTheme(ChangeTheme event, Emitter<ThemeState> emit) async {
    await _setValue(PreferenceConstants.isDarkMode, event.isDarkMode);

    emit(state.copyWith(isDarkMode: event.isDarkMode));
  }

  void _markAsFirstLaunched(
      MarkAsFirstLaunched event, Emitter<ThemeState> emit) async {
    await preferencesRepository.set(PreferenceConstants.isFirstLaunch, true);

    emit(state.copyWith(isFirstLaunch: true));
  }

  Future<bool> _getBoolValue(String key) async {
    return (await preferencesRepository.get(key)) as bool? ?? false;
  }

  Future<void> _setValue(String key, bool value) async {
    (await SharedPreferences.getInstance()).setBool(key, value);
    return;
  }
}

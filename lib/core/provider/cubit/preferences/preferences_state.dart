part of 'preferences_cubit.dart';

class PreferenceState {
  final String? themeName; 
  final ThemeData? theme;
  final String? langCode;

  PreferenceState({this.themeName, this.theme,this.langCode});

  PreferenceState copyWith({
    String? themeName,
    ThemeData? theme,
    String? langCode,
  }) {
    return PreferenceState(
      themeName:themeName ?? this.themeName,
      theme:theme ?? this.theme,
      langCode: langCode??this.langCode,
    );
  }
  static get empty=>PreferenceState();
}

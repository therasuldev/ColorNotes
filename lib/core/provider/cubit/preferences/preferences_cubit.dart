import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/core/app/note.dart';

import '../../../app/themes.dart';

part 'preferences_state.dart';

class PreferenceCubit extends Cubit<PreferenceState> {
  PreferenceCubit() : super(PreferenceState.empty);
  final note = Note();

  final themes = {'dark': Themes().dark, 'light': Themes().light};

  Future<void> initApp() async {
    final lang = await currentLang;
    final themeName = await currentTheme;

    emit(state.copyWith(
      langCode: lang,
      themeName: themeName,
      theme: themes[themeName],
    ));
  }

  Future<void> changeTheme(dynamic newTheme) async {
    final service = note.cacheService.preferences;
    try {
      await service.put('theme', newTheme);
      emit(
        state.copyWith(
          theme: themes[newTheme] ?? themes['light'],
          themeName: newTheme,
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> changeLang(dynamic newLang) async {
    try {
      await note.cacheService.preferences.put('language', newLang);
      emit(state.copyWith(langCode: newLang));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String?> get currentTheme async {
    final service = note.cacheService.preferences;
    final appTheme = await service.get('theme');

    return appTheme ?? 'light';
  }

  Future<String?> get currentLang async {
    final appLang = await note.cacheService.preferences.get('language');
    return appLang ?? 'az';
  }
}

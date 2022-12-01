import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smallnotes/core/provider/bloc/note/note_bloc.dart';
import 'package:smallnotes/core/provider/bloc/search_history/search_history_bloc.dart';
import 'package:smallnotes/core/provider/cubit/preferences/preferences_cubit.dart';
import 'package:smallnotes/gen/assets.gen.dart';
import 'package:smallnotes/note.dart';
import 'package:smallnotes/view/widgets/settings/settings_logo.dart';
import 'package:smallnotes/view/widgets/settings/settings_tile.dart';

import '../../../core/app/themes.dart';
import '../pop_up_menu_bar.dart';

class Settings extends NoteStatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends NoteState<Settings> {
  late PreferenceCubit prefCubit;

  @override
  void initState() {
    prefCubit = BlocProvider.of<PreferenceCubit>(context);
    setDefaultValues();
    super.initState();
  }

  bool _themeSwitchValue = false;
  void setDefaultValues() async {
    final theme = await prefCubit.currentTheme;
    setState(() => _themeSwitchValue = theme.toString() == Themes.darkID);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 20),
            BlocBuilder<PreferenceCubit, PreferenceState>(
              builder: (context, state) {
                return SettingsTile(
                  child: Row(
                    children: [
                      SettingsLogo(
                        color: AppColors.green.withOpacity(.7),
                        child: const Icon(Icons.language),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        note.fmt(context, 'app.lang'),
                        style: const TextStyle(fontSize: 16),
                      ),
                      Expanded(child: Container()),
                      PopUpMenuBar(
                        baseIcon: PhosphorIcons.selectionAllBold,
                        iconColor: AppColors.blueGrey,
                        items: [
                          PopUpMenuBarItem(
                            title: note.fmt(context, 'lang.az'),
                            tralling: const Text(
                              '🇦🇿',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          PopUpMenuBarItem(
                            title: note.fmt(context, 'lang.ru'),
                            tralling: const Text(
                              '🇷🇺',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          PopUpMenuBarItem(
                            title: note.fmt(context, 'lang.en'),
                            tralling: const Text(
                              '🇬🇧',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                        onSelect: (i) async {
                          final values = {0: 'az', 1: 'ru', 2: 'en'};
                          if (state.langCode == values[i]) return;

                          await prefCubit.changeLang(values[i]);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<PreferenceCubit, PreferenceState>(
              builder: (context, state) {
                return SettingsTile(
                  child: Row(
                    children: [
                      SettingsLogo(
                        color: AppColors.blueGrey.withOpacity(.7),
                        child: const Icon(Icons.auto_awesome),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        note.fmt(context, 'app.theme'),
                        style: const TextStyle(fontSize: 16),
                      ),
                      Expanded(child: Container()),
                      SizedBox(
                        height: 55,
                        width: 45,
                        child: DayNightSwitcherIcon(
                          isDarkModeEnabled: _themeSwitchValue,
                          onStateChanged: (value) async {
                            final themeName =
                                value ? Themes.darkID : Themes.lightID;
                            setState(() => _themeSwitchValue = value);
                            await prefCubit.changeTheme(themeName);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () async => deleteCache(),
              child: SettingsTile(
                child: Row(
                  children: [
                    SettingsLogo(
                      color: AppColors.darkYellow.withOpacity(.7),
                      child: const Icon(Icons.delete_sweep),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      note.fmt(context, 'settings.cache'),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => SystemNavigator.pop(),
              child: SettingsTile(
                child: Row(
                  children: [
                    SettingsLogo(
                      color: AppColors.red.withOpacity(.7),
                      child: const Icon(Icons.logout_rounded),
                    ),
                    const SizedBox(width: 5),
                    Text(note.fmt(context, 'settings.exit'),
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
              ),
            ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 45,
                    width: 45,
                    alignment: Alignment.center,
                    decoration: logoDecor(),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    note.fmt(context, 'team'),
                    style: GoogleFonts.rubikMoonrocks(fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration logoDecor() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(image: AssetImage(Assets.img.notes.path)),
    );
  }

  Future<void> deleteCache() {
    return showDialog<AlertDialog>(
      context: context,
      builder: (_) {
        return GenerateDialog(
          context: context,
          title: note.fmt(context, 'info.title'),
          cancelTitle: note.fmt(context, 'dialog.close'),
          actTitle: note.fmt(context, 'dialog.check'),
          onAct: () async {
            removeCache();
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void removeCache() {
    var notebloc = BlocProvider.of<NotesBloc>(context);
    var historybloc = BlocProvider.of<SearchHistoryBloc>(context);
    removeAllNotes(notebloc);
    removeAllHistory(historybloc);
    removeAllFavoriteKeys();
    changeLangToAZ();
  }

  void removeAllNotes(NotesBloc bloc) {
    var keys = note.cacheService.noteService.keys.toList();
    bloc.add(RemoveAllNotes(keys: keys));
  }

  void removeAllHistory(SearchHistoryBloc bloc) {
    var keys = note.cacheService.searchPref.keys.toList();
    bloc.add(RemoveAllHistory(keys: keys));
  }

  void removeAllFavoriteKeys() {
    var fKeys = note.cacheService.favoriteKeys.keys;
    note.cacheService.favoriteKeys.deleteAll(fKeys);
  }

  void changeLangToAZ() {
    context.read<PreferenceCubit>().changeLang('az');
  }
}

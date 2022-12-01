import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smallnotes/core/app/intl.dart';
import 'package:smallnotes/core/provider/bloc/search/search_bloc.dart';
import 'package:smallnotes/core/provider/bloc/search_history/search_history_bloc.dart';
import 'package:smallnotes/core/provider/cubit/preferences/preferences_cubit.dart';
import 'package:smallnotes/injection_container.dart';

import 'core/provider/bloc/note/note_bloc.dart';
import 'note.dart';

class MyApp extends NoteStatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends NoteState<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotesBloc>(create: (context) => di.get()..add(GetNote())),
        BlocProvider<SearchHistoryBloc>(
            create: (context) => di.get()..add(GetHistory())),
        BlocProvider<PreferenceCubit>(create: (context) => di.get()..initApp()),
        BlocProvider<SearchBloc>(create: (context) => di()),
      ],
      child: BlocBuilder<PreferenceCubit, PreferenceState>(
        builder: (context, state) {
          return MaterialApp(
            theme: state.theme,
            debugShowCheckedModeBanner: false,
            home: AppRoute.toGeneralHome,
            title: 'Color Notes',
            localizationsDelegates: [
              note.intl.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
                child: child ?? const SizedBox.shrink(),
              );
            },
            supportedLocales: languages.map((lang) => Locale(lang, '')),
            locale: Locale(state.langCode ?? note.intl.locale.languageCode),
          );
        },
      ),
    );
  }
}

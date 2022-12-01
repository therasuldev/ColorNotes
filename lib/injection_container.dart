import 'package:get_it/get_it.dart';
import 'package:smallnotes/core/database/notes_database.dart';
import 'package:smallnotes/core/database/search_history.dart';
import 'package:smallnotes/core/provider/bloc/note/note_bloc.dart';
import 'package:smallnotes/core/provider/cubit/preferences/preferences_cubit.dart';

import 'core/provider/bloc/search/search_bloc.dart';
import 'core/provider/bloc/search_history/search_history_bloc.dart';

GetIt di = GetIt.instance;
setup() async {
  di.registerFactory(() => NotesBloc());
  di.registerFactory(() => SearchBloc());
  di.registerFactory(() => SearchHistoryBloc());

  di.registerLazySingleton(() => DBhelper());
  di.registerLazySingleton(() => SHhelper());
  di.registerLazySingleton(() => PreferenceCubit());
}

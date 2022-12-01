import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:smallnotes/app.dart';
import 'package:smallnotes/core/app/intl.dart';
import 'package:smallnotes/core/app/note.dart';
import 'package:smallnotes/core/app/themes.dart';
import 'package:smallnotes/core/model/note_model.dart';
import 'package:smallnotes/core/service/cache_service.dart';
import 'package:smallnotes/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Hive.isAdapterRegistered(0)) Hive.registerAdapter(NoteModelAdapter());
  final note = Note();

  await Hive.initFlutter();
  await Hive.openBox<NoteModel>('allnotes');
  await Hive.openBox('preferences');
  await Hive.openBox('favoritekeys');
  await Hive.openBox('searchHistory');

  note.themes = Themes();
  note.intl = Intl();
  note.cacheService = CacheService();
  note.intl.locale = const Locale('az');
  note.intl.supportedLocales = languages;

  await setup();
  runApp(MyApp());
}

import 'package:hive/hive.dart';

import '../model/note_model.dart';

class CacheService {
  Box get preferences => Hive.box('preferences');
  Box get lang => Hive.box('language');
  Box<NoteModel> get noteService => Hive.box<NoteModel>('allnotes');
  Box get searchPref => Hive.box('searchHistory');
  Box get favoriteKeys => Hive.box('favoritekeys');

  bool get isSPreferencesSetted => searchPref.isNotEmpty;
  bool get isPreferencesSetted => lang.isNotEmpty;
  bool get isNPreferencesSetted => noteService.isNotEmpty;
  bool get isFPreferencesSetted => favoriteKeys.isNotEmpty;
}

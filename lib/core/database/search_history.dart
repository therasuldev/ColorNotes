import 'package:smallnotes/core/app/note.dart';

class SHhelper {
  final note = Note();

  Future<List<dynamic>> addHistory(dynamic key, dynamic history) async {
    final service = note.cacheService.searchPref;
    await service.put(key, history);
    return getHistory();
  }

  List<dynamic> getHistory() {
    final service = note.cacheService.searchPref;
    var values = service.values.toList();
    return values;
  }

  Future<List<dynamic>> removeHistory(dynamic key) async {
    final service = note.cacheService.searchPref;
    await service.delete(key);
    return getHistory();
  }

  Future<List<dynamic>> removeAllHistory(List<dynamic> keys) async {
    final service = note.cacheService.searchPref;
    await service.deleteAll(keys);
    return getHistory();
  }
}

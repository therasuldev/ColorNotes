import 'package:smallnotes/core/app/note.dart';
import 'package:smallnotes/core/model/note_model.dart';

class DBhelper {
  final note = Note();

  Future<List<NoteModel>> addNote(String key, NoteModel model) async {
    final service = note.cacheService.noteService;
    await service.put(key, model);
    return getNotes();
  }

  Future<List<NoteModel>> getNotes() async {
    final service = note.cacheService.noteService;
    var values = service.values.toList();
    values.sort((a, b) => b.dateCreate.compareTo(a.dateCreate));
    return values;
  }

  Future<List<NoteModel>> removeNote(String key) async {
    final service = note.cacheService.noteService;
    await service.delete(key);
    return getNotes();
  }

  Future<List<NoteModel>> removeAllNotes(List<dynamic> keys) async {
    final service = note.cacheService.noteService;
    await service.deleteAll(keys);
    return getNotes();
  }

  Future<List<NoteModel>> updateNote(String key, NoteModel model) async {
    final service = note.cacheService.noteService;
    await service.put(key, model);
    return getNotes();
  }
}

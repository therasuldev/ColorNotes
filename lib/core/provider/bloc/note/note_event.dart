part of 'note_bloc.dart';

@immutable
abstract class NoteEvent {}

class AddNote extends NoteEvent {
  final String key;
  final NoteModel model;

  AddNote({required this.model, required this.key});
}

class GetNote extends NoteEvent {}

class RemoveNote extends NoteEvent {
  final String key;

  RemoveNote({required this.key});
}

class RemoveAllNotes extends NoteEvent {
  final List<dynamic> keys;

  RemoveAllNotes({required this.keys});
}

class UpdateNote extends NoteEvent {
  final String key;
  final NoteModel model;

  UpdateNote({required this.key, required this.model});
}

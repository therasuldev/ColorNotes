import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/core/database/notes_database.dart';
import 'package:smallnotes/core/model/note_model.dart';

part 'note_event.dart';
part 'note_state.dart';

class NotesBloc extends Bloc<NoteEvent, NotesState> {
  final DBhelper dbHelper = DBhelper();

  NotesBloc() : super(const NotesState.unknown()) {
    on<AddNote>(_onAddNoteEvent);
    on<GetNote>(_onGetNoteEvent);
    on<RemoveNote>(_onRemoveNoteEvent);
    on<RemoveAllNotes>(_onRemoveAllNotesEvent);
    on<UpdateNote>(_onUpdateNoteEvent);
  }
  void _onAddNoteEvent(AddNote event, Emitter<NotesState> emit) async {
    try {
      emit(const NotesState.loading());
      final model = await dbHelper.addNote(event.key, event.model);
      final fNum = model.where((element) => element.isFavorite).length;
      emit(NotesState.success(model: model, favoriteNum: fNum));
    } catch (message) {
      emit(NotesState.failed(message.toString()));
    }
  }

  void _onGetNoteEvent(GetNote event, Emitter<NotesState> emit) async {
    try {
      emit(const NotesState.loading());
      final model = await dbHelper.getNotes();
      final fNum =  model.where((element) => element.isFavorite).length;
      emit(NotesState.success(model: model, favoriteNum: fNum));
    } catch (message) {
      emit(NotesState.failed(message.toString()));
    }
  }

  void _onRemoveNoteEvent(RemoveNote event, Emitter<NotesState> emit) async {
    try {
      emit(const NotesState.loading());
      final model = await dbHelper.removeNote(event.key);
      final fNum = model.where((element) => element.isFavorite).length;
      emit(NotesState.success(model: model, favoriteNum: fNum));
    } catch (message) {
      emit(NotesState.failed(message.toString()));
    }
  }

  void _onRemoveAllNotesEvent(
      RemoveAllNotes event, Emitter<NotesState> emit) async {
    try {
      emit(const NotesState.loading());
      final model = await dbHelper.removeAllNotes(event.keys);
      final fNum = model.where((element) => element.isFavorite).length;
      emit(NotesState.success(model: model, favoriteNum: fNum));
    } catch (message) {
      emit(NotesState.failed(message.toString()));
    }
  }

  void _onUpdateNoteEvent(UpdateNote event, Emitter<NotesState> emit) async {
    try {
      emit(const NotesState.loading());
      final model = await dbHelper.updateNote(event.key, event.model);
      final fNum = model.where((element) => element.isFavorite).length;
      emit(NotesState.success(model: model, favoriteNum: fNum));
    } catch (message) {
      emit(NotesState.failed(message.toString()));
    }
  }
}

part of 'note_bloc.dart';

@immutable
class NotesState {
  final List<NoteModel>? model;
  final String? error;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final int favoriteNum;

  const NotesState({
    required this.model,
    required this.error,
    required this.isFailure,
    required this.isLoading,
    required this.isSuccess,
    required this.favoriteNum,
  });

  const NotesState.unknown()
      : this(
          error: null,
          model: null,
          isFailure: false,
          isLoading: true,
          isSuccess: false,
          favoriteNum: 0,
        );
  const NotesState.loading()
      : this(
          error: null,
          model: null,
          isFailure: false,
          isLoading: true,
          isSuccess: false,
          favoriteNum: 0,
        );
  NotesState.success(
      {required List<NoteModel>? model, required int favoriteNum})
      : this(
          error: null,
          model: model ?? [],
          isFailure: false,
          isLoading: false,
          isSuccess: true,
          favoriteNum: favoriteNum,
        );
  const NotesState.failed(String error)
      : this(
          error: error,
          model: null,
          isFailure: true,
          isLoading: false,
          isSuccess: false,
          favoriteNum: 0,
        );
}

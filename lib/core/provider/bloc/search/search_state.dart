part of 'search_bloc.dart';

@immutable
class SearchState {
  final List<NoteModel>? model;
  final String? error;
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;

  const SearchState({
    required this.model,
    required this.error,
    required this.isFailure,
    required this.isLoading,
    required this.isSuccess,
  });

  const SearchState.unknown()
      : this(
          error: null,
          model: null,
          isFailure: false,
          isLoading: true,
          isSuccess: false,
        );
  const SearchState.loading()
      : this(
          error: null,
          model: null,
          isFailure: false,
          isLoading: true,
          isSuccess: false,
        );
  const SearchState.success({required List<NoteModel> model})
      : this(
          error: null,
          model: model,
          isFailure: false,
          isLoading: false,
          isSuccess: true,
        );
}

part of 'search_history_bloc.dart';

class SearchHistoryState {
  final bool isLoading;
  final bool isSuccess;
  final List<dynamic>? history;

  SearchHistoryState(
      {required this.isLoading, required this.isSuccess, this.history});
  SearchHistoryState.unknown()
      : this(isLoading: true, isSuccess: false, history: null);
  SearchHistoryState.loading()
      : this(isLoading: true, isSuccess: false, history: null);
  SearchHistoryState.success({required List<dynamic> history})
      : this(isLoading: false, isSuccess: true, history: history);
}

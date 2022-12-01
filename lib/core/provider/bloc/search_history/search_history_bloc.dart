import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/search_history.dart';

part 'search_history_event.dart';
part 'search_history_state.dart';

class SearchHistoryBloc extends Bloc<SearchHistoryEvent, SearchHistoryState> {
  final helper = SHhelper();
  SearchHistoryBloc() : super(SearchHistoryState.unknown()) {
    on<AddHistory>(_onAddHistory);
    on<GetHistory>(_onGetHistory);
    on<RemoveHistory>(_onRemoveHistory);
    on<RemoveAllHistory>(_onRemoveAllHistory);
  }
  void _onAddHistory(AddHistory event, Emitter<SearchHistoryState> emit) async {
    emit(SearchHistoryState.loading());
    final history = await helper.addHistory(event.key, event.history);
    emit(SearchHistoryState.success(history: history));
  }

  void _onGetHistory(GetHistory event, Emitter<SearchHistoryState> emit) async {
    emit(SearchHistoryState.loading());
    final history = helper.getHistory();
    emit(SearchHistoryState.success(history: history));
  }

  void _onRemoveHistory(
      RemoveHistory event, Emitter<SearchHistoryState> emit) async {
    emit(SearchHistoryState.loading());
    final history = await helper.removeHistory(event.key);
    emit(SearchHistoryState.success(history: history));
  }

  void _onRemoveAllHistory(
      RemoveAllHistory event, Emitter<SearchHistoryState> emit) async {
    emit(SearchHistoryState.loading());
    final history = await helper.removeAllHistory(event.keys);
    emit(SearchHistoryState.success(history: history));
  }
}

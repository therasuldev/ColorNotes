import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../database/notes_database.dart';
import '../../../model/note_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  DBhelper dbnHelper = DBhelper();
  SearchBloc() : super(const SearchState.unknown()) {
    on<Search>(_onSearch);
  }
  void _onSearch(Search event, Emitter<SearchState> emit) async {
    try {
      emit(const SearchState.loading());
      final model = await dbnHelper.getNotes();

      final result = model
          .where(
            (element) => element.titleNote
                .toLowerCase()
                .contains(event.query.toLowerCase()),
          )
          .toList();

      emit(SearchState.success(model: result));
    } catch (_) {}
  }
}

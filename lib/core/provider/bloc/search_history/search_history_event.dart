part of 'search_history_bloc.dart';

abstract class SearchHistoryEvent {}

class AddHistory extends SearchHistoryEvent {
  final dynamic key;
  final dynamic history;

  AddHistory({required this.key, this.history});
}

class GetHistory extends SearchHistoryEvent {}

class RemoveHistory extends SearchHistoryEvent {
  final dynamic key;

  RemoveHistory({required this.key});
}

class RemoveAllHistory extends SearchHistoryEvent {
  final List<dynamic> keys;

  RemoveAllHistory({required this.keys});
}

//import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/core/app/note.dart';
import 'package:smallnotes/core/provider/bloc/search_history/search_history_bloc.dart';
import 'package:smallnotes/note.dart';
import 'package:smallnotes/view/widgets/empty_widget.dart';

import '../../core/provider/bloc/search/search_bloc.dart';

class NoteSearchDelegate extends SearchDelegate {
  final SearchBloc searchBloc;
  final note = Note();

  NoteSearchDelegate({required this.searchBloc});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      CloseButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return BackButton(onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(Search(query: query.toLowerCase()));
    if (query.isNotEmpty) {
      context
          .read<SearchHistoryBloc>()
          .add(AddHistory(key: query, history: query));
    }

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: BallSpinFadeLoader());
        } else if (state.isSuccess) {
          if (state.model!.isEmpty || query.isEmpty) {
            return EmptyWidget();
          }
          return ListView.builder(
            itemCount: state.model?.length ?? 0,
            itemBuilder: (context, index) {
              var model = state.model![index];
              final keys = note.cacheService.noteService.keys.toList();
              return GestureDetector(
                onTap: () => AppRoute.toShowItemPG(context, keys[index], model),
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: ItemCard(
                      borderColor: AppColors.blackAccent.value,
                      color: model.backgroundColor),
                  width: size(context).width,
                  height: 70,
                  child: NoteModelComponentsView(model: model),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchBloc.add(Search(query: query.toLowerCase()));

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(child: BallSpinFadeLoader());
        } else if (state.isSuccess) {
          if (state.model!.isEmpty || query.isEmpty) {
            return EmptyWidget();
          }
          return ListView.builder(
            itemCount: state.model?.length ?? 0,
            itemBuilder: (context, index) {
              var model = state.model![index];
              final keys = note.cacheService.noteService.keys.toList();
              return GestureDetector(
                onTap: () {
                  context.read<SearchHistoryBloc>().add(AddHistory(
                      key: model.titleNote, history: model.titleNote));

                  AppRoute.toShowItemPG(context, keys[index], model);
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: ItemCard(
                      borderColor: AppColors.blackAccent.value,
                      color: model.backgroundColor),
                  width: size(context).width,
                  height: 70,
                  child: NoteModelComponentsView(model: model),
                ),
              );
            },
          );
        }

        return EmptyWidget();
      },
    );
  }
}

class NoteModelComponentsView extends NoteStatelessWidget {
  final NoteModel model;
  NoteModelComponentsView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                width: size(context).width * .7,
                height: 30,
                color: AppColors.transparent,
                child: Text(
                  model.titleNote,
                  style: TextStyle(color: Color(model.textColor), fontSize: 18),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Text(
              model.dateCreate,
              maxLines: 1,
              style: TextStyle(
                  color: Color(model.textColor),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(
          model.textNote,
          maxLines: 1,
          style: TextStyle(color: Color(model.textColor), fontSize: 16),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/note.dart';
import 'package:smallnotes/view/widgets/search_delegate.dart';

import '../../../core/provider/bloc/search/search_bloc.dart';
import '../../../core/provider/bloc/search_history/search_history_bloc.dart';

class Search extends NoteStatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends NoteState<Search> with SearchMixin {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          shrinkWrap: true,
          slivers: [
            SliverAppBarWidget(),
            SliverToBoxAdapter(child: bodyTabBar(context)),
            SliverList(delegate: SliverChildListDelegate(_children())),
          ],
        ),
      ),
    );
  }

  Widget bodyTabBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            note.fmt(context, 'search.history'),
            style: Theme.of(context).textTheme.headline6,
          ),
          TextButton(
            onPressed: deleteAllHistory,
            child: Text(
              note.fmt(context, 'deleteAll.history'),
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                  color: AppColors.blue),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _children() {
    return [
      BlocBuilder<SearchHistoryBloc, SearchHistoryState>(
        builder: (context, state) {
          if (state.isLoading) {
            return LinearProgressIndicator(color: AppColors.black);
          }
          if (state.isSuccess) {
            if (state.history!.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 250, left: 120, right: 50),
                child: Text(note.fmt(context, 'history.isEmpty'),
                    style: Theme.of(context).textTheme.headline6),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.history?.length ?? 0,
                controller: scrollController,
                itemBuilder: (context, index) {
                  return HistoryCard(state: state, index: index);
                },
              );
            }
          }
          return const SizedBox.shrink();
        },
      )
    ];
  }
}

class SliverAppBarWidget extends NoteStatelessWidget {
  SliverAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 50,
      centerTitle: true,
      title: Text(note.fmt(context, 'search')),
      actions: [
        IconButton(
          onPressed: () {
            showSearch(
              context: context,
              delegate: NoteSearchDelegate(
                searchBloc: context.read<SearchBloc>(),
              ),
            );
          },
          icon: const Icon(Icons.search),
        )
      ],
    );
  }
}

class HistoryCard extends NoteStatelessWidget {
  HistoryCard({Key? key, required this.index, required this.state})
      : super(key: key);

  final int index;
  final SearchHistoryState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(bottom: 10, left: 5, right: 5),
      decoration: HistoryCardDecoration(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                state.history![index],
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            IconButton(
              onPressed: () {
                context
                    .read<SearchHistoryBloc>()
                    .add(RemoveHistory(key: state.history![index]));
              },
              icon: Icon(Icons.remove_circle, color: AppColors.red),
            )
          ],
        ),
      ),
    );
  }
}

mixin SearchMixin on NoteState<Search> {
  final scrollController = ScrollController();
  final searchBloc = SearchHistoryBloc();

  void deleteAllHistory() async {
    if (searchBloc.state.isLoading) BallSpinFadeLoader();
    var keys = note.cacheService.searchPref.keys.toList();
    context.read<SearchHistoryBloc>().add(RemoveAllHistory(keys: keys));
  }
}

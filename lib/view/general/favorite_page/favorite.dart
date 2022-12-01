import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/note.dart';
import 'package:smallnotes/view/model/favorite_model_view.dart';
import 'package:smallnotes/view/widgets/empty_widget.dart';

import '../../../core/provider/bloc/note/note_bloc.dart';

class FavoritePG extends NoteStatefulWidget {
  FavoritePG({Key? key}) : super(key: key);

  @override
  State<FavoritePG> createState() => _FavoritePGState();
}

class _FavoritePGState extends NoteState<FavoritePG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<NotesBloc>(context);
          if (state.isLoading) {
            return BallSpinFadeLoader();
          } else if (state.isFailure) {
            return const Center(child: Text('🙅'));
          } else if (state.isSuccess) {
            return !note.cacheService.isFPreferencesSetted
                ? EmptyWidget()
                : bodyListViewBuilder(state, bloc);
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget bodyListViewBuilder(NotesState state, NotesBloc bloc) {
    var model = state.model!.where((element) => element.isFavorite).toList();
    return ListView.builder(
      itemExtent: 200,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: model.length,
      itemBuilder: (BuildContext context, int index) {
        var keys = note.cacheService.favoriteKeys.keys.toList();
        var favoriteKeys = note.cacheService.favoriteKeys.keys.toList();
        return GestureDetector(
          onTap: () => AppRoute.toShowItem(context, keys[index], model[index]),
          child:
              FavoriteModelView(id: favoriteKeys[index], model: model[index]),
        );
      },
    );
  }
}

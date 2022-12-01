import 'package:drag_select_grid_view/drag_select_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smallnotes/note.dart';
import 'package:smallnotes/view/model/note_model_view.dart';
import 'package:smallnotes/view/widgets/empty_widget.dart';

import '../../../core/provider/bloc/note/note_bloc.dart';
import 'components/number_of_notes.dart';

class AllNotesView extends NoteStatefulWidget {
  AllNotesView({Key? key}) : super(key: key);

  @override
  State<AllNotesView> createState() => _AllNotesViewState();
}

class _AllNotesViewState extends NoteState<AllNotesView>
    with AllNotesViewMixin {
  @override
  Widget build(BuildContext context) {
    isSelecting = gController.value.isSelecting;
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: isSelecting ? _appBarWidget(state) : null,
          body: state.isLoading
              ? LoadingBodyWidget()
              : SuccessBodyWidget(
                  state: state,
                  isSelecting: isSelecting,
                  controller: gController,
                ),
        );
      },
    );
  }

  AppBar _appBarWidget(NotesState state) {
    return AppBar(
      actions: [
        IconButton(
          onPressed: deleteSelectedNote,
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
        ),
        CloseButton(onPressed: () => gController.clear()),
      ],
      leading: Center(
        child: Text('${gController.value.amount}/${state.model?.length ?? 0}',
            style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}

class LoadingBodyWidget extends NoteStatelessWidget {
  LoadingBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: BallSpinFadeLoader());
  }
}

class SuccessBodyWidget extends NoteStatelessWidget {
  SuccessBodyWidget({
    Key? key,
    required this.state,
    required this.isSelecting,
    required this.controller,
  }) : super(key: key);

  final NotesState state;
  final bool isSelecting;
  final DragSelectGridViewController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        const Padding(padding: EdgeInsets.only(top: 15)),
        Column(
          children: [
            isSelecting
                ? const SizedBox.shrink()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AllNoteNum(noteNum: state.model?.length ?? 0),
                      FavoriteNum(favoriteNum: state.favoriteNum)
                    ],
                  ),
            Padding(padding: EdgeInsets.only(bottom: isSelecting ? 0 : 15)),
            !note.cacheService.isNPreferencesSetted
                ? Padding(
                    padding: EdgeInsets.only(top: size(context).height * .25),
                    child: EmptyWidget(),
                  )
                : DragSelectGridViewW(state: state, controller: controller),
          ],
        )
      ],
    );
  }
}

class DragSelectGridViewW extends NoteStatelessWidget {
  DragSelectGridViewW({Key? key, required this.controller, required this.state})
      : super(key: key);

  final DragSelectGridViewController controller;
  final NotesState state;

  @override
  Widget build(BuildContext context) {
    return DragSelectGridView(
      gridController: controller,
      itemCount: state.model?.length ?? 0,
      shrinkWrap: true,
      itemBuilder: (context, index, selected) {
        final keys = note.cacheService.noteService.keys.toList();
        final model = state.model![index];
        return GestureDetector(
          onTap: () => AppRoute.toShowItem(context, keys[index], model),
          child: NoteModelView(
            model: model,
            selectItems: controller.value.selectedIndexes.toList(),
            index: index,
          ),
        );
      },
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
    );
  }
}

mixin AllNotesViewMixin on NoteState<AllNotesView> {
  final gController = DragSelectGridViewController();
  bool isSelecting = false;

  @override
  void initState() {
    super.initState();
    gController.addListener(scheduleRebuild);
  }

  @override
  void dispose() {
    gController.removeListener(scheduleRebuild);
    super.dispose();
  }

  void scheduleRebuild() {
    setState(() {});
  }

  deleteSelectedNote() {
    var allKeys = note.cacheService.noteService.keys.toList();
    var selected =
        gController.value.selectedIndexes.map((key) => allKeys[key]).toList();

    context.read<NotesBloc>().add(RemoveAllNotes(keys: selected));
    note.cacheService.favoriteKeys.deleteAll(selected);

    Navigator.pop(context);
  }
}

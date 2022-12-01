import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/provider/bloc/note/note_bloc.dart';
import '../../note.dart';

class FavoriteModelView extends NoteStatefulWidget {
  final NoteModel model;
  final String id;
  FavoriteModelView({Key? key, required this.model, required this.id})
      : super(key: key);

  @override
  State<FavoriteModelView> createState() => _FavoriteModelViewState();
}

class _FavoriteModelViewState extends NoteState<FavoriteModelView> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: UpperNipMessageClipper(MessageType.send),
      child: Container(
        color: Color(widget.model.backgroundColor),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: _favoriteModelElements(context),
      ),
    );
  }

  Widget _favoriteModelElements(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.favorite),
              color: AppColors.red,
              iconSize: 25,
              onPressed: removeFromFavorites,
            ),
            Expanded(child: Container()),
            Text(
              widget.model.dateCreate,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(widget.model.textColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 3),
        Flexible(
          child: Text(
            widget.model.titleNote,
            maxLines: 1,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color(widget.model.textColor),
            ),
          ),
        ),
        Flexible(
          child: Text(
            widget.model.textNote,
            maxLines: 6,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w300,
              color: Color(widget.model.textColor),
            ),
          ),
        ),
      ],
    );
  }

  void removeFromFavorites() {
    showDialog(
      context: context,
      builder: (context) {
        return GenerateDialog(
          context:context,
          title: note.fmt(context, 'delete.favorite'),
          cancelTitle: note.fmt(context, 'dialog.close'),
          actTitle: note.fmt(context, 'dialog.check'),
          onAct: _removeFromFavorite,
        );

     
      },
    );
  }

  void _removeFromFavorite() {
    final model = NoteModel(
      titleNote: widget.model.titleNote,
      textNote: widget.model.textNote,
      dateCreate: widget.model.dateCreate,
      backgroundColor: widget.model.backgroundColor,
      textColor: widget.model.textColor,
      isFavorite: false,
    );
    note.cacheService.favoriteKeys.delete(widget.id);
    context.read<NotesBloc>().add(UpdateNote(key: widget.id, model: model));
    setState(() => widget.model.isFavorite = false);
    Navigator.pop(context);
  }
}

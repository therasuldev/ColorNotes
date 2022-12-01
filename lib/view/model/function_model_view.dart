import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/provider/bloc/note/note_bloc.dart';
import '../../note.dart';

class FunctionModelView extends NoteStatefulWidget {
  final String id;
  final NoteModel model;
  final void Function()? editNote;
  final void Function()? editedNote;
  final GlobalKey rKey;
  final bool editItem;

  FunctionModelView({
    Key? key,
    required this.id,
    required this.rKey,
    required this.model,
    required this.editItem,
    required this.editNote,
    required this.editedNote,
  }) : super(key: key);

  @override
  State<FunctionModelView> createState() => _FunctionModelViewState();
}

class _FunctionModelViewState extends NoteState<FunctionModelView>
    with FunctionModelViewMixin {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: size(context).width,
          height: 50,
          decoration: CatalogForItemCard(context: context),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: widget.model.isFavorite
                    ? Icon(Icons.favorite, color: iconColor)
                    : Icon(PhosphorIcons.heartBold, color: iconColor),
                onPressed: () => addToFavorite(),
              ),
              IconButton(
                icon: widget.editItem
                    ? Icon(PhosphorIcons.check, color: AppColors.green)
                    : const Icon(PhosphorIcons.pencilLight),
                onPressed:
                    !widget.editItem ? widget.editNote : widget.editedNote,
              ),
              IconButton(
                icon: const Icon(PhosphorIcons.scan),
                onPressed: () => takeScreenshot(context),
              ),
              IconButton(
                icon: const Icon(PhosphorIcons.share),
                onPressed: () => onShareWithResult(),
              ),
              IconButton(
                icon:
                    Icon(Icons.delete_forever, color: AppColors.selectedColor),
                onPressed: () => removeItem(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

mixin FunctionModelViewMixin on NoteState<FunctionModelView> {
  final titleController = TextEditingController();
  final textController = TextEditingController();

  Color iconColor = AppColors.red;
  String newTitleNote = '';
  String newTextNote = '';

  void addToFavorite() async {
    if (widget.model.isFavorite) {
      return showDialog(
        context: context,
        builder: (context) {
          return GenerateDialog(
              context: context,
              title: note.fmt(context, 'delete.favorite'),
              cancelTitle: note.fmt(context, 'dialog.close'),
              actTitle: note.fmt(context, 'dialog.check'),
              onAct: _removeFromFavorite);
        },
      );
    } else if (!widget.model.isFavorite) {
      final model = NoteModel(
        titleNote: widget.model.titleNote,
        textNote: widget.model.textNote,
        dateCreate: widget.model.dateCreate,
        backgroundColor: widget.model.backgroundColor,
        textColor: widget.model.textColor,
        isFavorite: true,
      );
      note.cacheService.favoriteKeys.put(widget.id, model);
      context.read<NotesBloc>().add(UpdateNote(key: widget.id, model: model));
      setState(() => widget.model.isFavorite = true);
    }
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

  void takeScreenshot(context) async {
    RenderRepaintBoundary boundary =
        widget.rKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    if (byteData != null) {
      Uint8List pngint8 = byteData.buffer.asUint8List();
      ImageGallerySaver.saveImage(Uint8List.fromList(pngint8),
          quality: 90, name: 'screenshot-${DateTime.now()}');
      final msg = note.fmt(context, 'save.image');
      await ViewUtils.showSnack(context, msg: msg, color: AppColors.green);
    } else {
      final msg = note.fmt(context, 'error.unknown');
      await ViewUtils.showSnack(context, msg: msg, color: AppColors.red);
    }
  }

  void onShareWithResult() async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.shareWithResult(
      widget.model.textNote,
      subject: widget.model.titleNote,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  void removeItemFromDB(context) async {
    final bloc = BlocProvider.of<NotesBloc>(context);

    bloc.add(RemoveNote(key: widget.id));
    note.cacheService.favoriteKeys.delete(widget.id);
    await AppRoute.toGeneralHome(context);
  }

  void removeItem() => showDialog(
        context: context,
        builder: (_) => GenerateDialog(
            context: context,
            title: note.fmt(context, 'delete.note'),
            cancelTitle: note.fmt(context, 'dialog.close'),
            actTitle: note.fmt(context, 'dialog.check'),
            onAct: () => removeItemFromDB(context)),
      );
}

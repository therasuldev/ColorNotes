import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smallnotes/note.dart';
import 'package:smallnotes/view/model/function_model_view.dart';

import '../../../core/provider/bloc/note/note_bloc.dart';

class ShowItem extends NoteStatefulWidget {
  ShowItem({required this.id, required this.model, Key? key}) : super(key: key);

  final String id;
  final NoteModel model;
  @override
  State<ShowItem> createState() => _ShowItemState();
}

class _ShowItemState extends NoteState<ShowItem> with ShowItemMixin {
  final scrollController = ScrollController();
  final GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FunctionModelView(
                id: widget.id,
                rKey: key,
                model: widget.model,
                editItem: editItem,
                editNote: editNote,
                editedNote: editedNote,
              ),
              const SizedBox(height: 10),
              editItem
                  ? _editNoteContainer(context)
                  : _showNoteContainer(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget _editNoteContainer(BuildContext context) {
    return RepaintBoundary(
      key: key,
      child: Container(
        height: size(context).height - 60,
        width: size(context).width,
        padding: const EdgeInsets.all(5),
        decoration: ShowAndEditItemCard(color: widget.model.backgroundColor),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.model.titleNote,
                scrollPadding: const EdgeInsets.all(0),
                enabled: true,
                maxLines: 2,
                decoration: UnderlineBorderDecoration(),
                style: TextStyle(
                    fontSize: 17, color: Color(widget.model.textColor)),
                onChanged: (newTitle) => setState(() {
                  newTitleNote = newTitle;
                }),
              ),
              TextFormField(
                initialValue: widget.model.textNote,
                scrollPadding: const EdgeInsets.all(0),
                enabled: true,
                maxLines: 100,
                maxLength: 1000,
                decoration: UnderlineBorderDecoration(),
                style: TextStyle(
                    fontSize: 17, color: Color(widget.model.textColor)),
                onChanged: (newText) => setState(() {
                  newTextNote = newText;
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _showNoteContainer(BuildContext context) {
    return RepaintBoundary(
      key: key,
      child: Container(
        height: size(context).height - 60,
        width: size(context).width,
        padding: const EdgeInsets.all(5),
        decoration: ShowAndEditItemCard(color: widget.model.backgroundColor),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.model.titleNote,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style:TextStyle(fontSize: 17, color: Color(widget.model.textColor)),
              ),
              Text(
                widget.model.textNote,
                overflow: TextOverflow.ellipsis,
                maxLines: 200,
                style:TextStyle(fontSize: 17, color: Color(widget.model.textColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

mixin ShowItemMixin on NoteState<ShowItem> {
  bool editItem = false;
  String newTitleNote = '';
  String newTextNote = '';

  void editNote() => setState(() => editItem = !editItem);

  void editedNote() async {
    final model = NoteModel(
      titleNote: newTitleNote == '' ? widget.model.titleNote : newTitleNote,
      textNote: newTextNote == '' ? widget.model.textNote : newTextNote,
      dateCreate: DateFormat('yyyy.MM.dd').format(DateTime.now()),
      backgroundColor: widget.model.backgroundColor,
      textColor: widget.model.textColor,
      isFavorite: widget.model.isFavorite,
    );

    context.read<NotesBloc>().add(UpdateNote(key: widget.id, model: model));
    setState(() => editItem = false);
    Navigator.pop(context);
  }
}

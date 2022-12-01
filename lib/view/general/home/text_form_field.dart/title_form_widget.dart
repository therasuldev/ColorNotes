import 'package:flutter/material.dart';
import 'package:smallnotes/note.dart';

class TitleForm extends NoteStatelessWidget {
  TitleForm({required this.titleNoteController, Key? key}) : super(key: key);

  final TextEditingController titleNoteController;

  @override
  Widget build(BuildContext context) {
    final String title = note.fmt(context, 'note.title');
    return Container(
      height: 50,
      width: size(context).width * .9,
      decoration: TextAndTitleCard(context: context),
      padding: const EdgeInsets.only(left: 7, top: 0),
      margin: const EdgeInsets.only(top: 30),
      child: TextFormField(
        style: Theme.of(context).textTheme.subtitle1,
        controller: titleNoteController,
        decoration: NonBorderDecoration(context: context, hint: title),
        autofocus: true,
      ),
    );
  }
}

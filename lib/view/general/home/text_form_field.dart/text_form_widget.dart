import 'package:flutter/material.dart';
import 'package:smallnotes/note.dart';

class TextForm extends NoteStatelessWidget {
  TextForm({
    required this.textNoteController,
    required this.noteLength,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  final TextEditingController textNoteController;
  final void Function(String)? onChanged;
  final int noteLength;

  @override
  Widget build(BuildContext context) {
    final hintText = note.fmt(context, 'note.text');
    return Container(
      height: size(context).height * .65,
      width: size(context).width * .9,
      decoration: TextAndTitleCard(context: context),
      padding: const EdgeInsets.only(left: 7, top: 0),
      margin: const EdgeInsets.only(top: 20),
      child: Stack(
        children: [
          TextFormField(
            style: Theme.of(context).textTheme.subtitle1,
            controller: textNoteController,
            decoration: NonBorderDecoration(context: context, hint: hintText),
            maxLines: 100,
            autofocus: true,
            onChanged: onChanged,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 20,
              width: 45,
              alignment: Alignment.center,
              decoration: DefaultDecor(),
              child:
                  Text('$noteLength', style: TextStyle(color: AppColors.white)),
            ),
          )
        ],
      ),
    );
  }
}

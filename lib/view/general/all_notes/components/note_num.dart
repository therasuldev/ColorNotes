import 'package:flutter/material.dart';
import 'package:smallnotes/note.dart';

class AllNoteNum extends NoteStatefulWidget {
  final int noteNum;
  AllNoteNum({Key? key, required this.noteNum}) : super(key: key);

  @override
  State<AllNoteNum> createState() => _AllNoteNumState();
}

class _AllNoteNumState extends State<AllNoteNum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      width: 66,
      decoration: NumCard(context: context, color: AppColors.black),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.notes, color: AppColors.black),
          Text(
            widget.noteNum.toString(),
            style: TextStyle(color: AppColors.black),
          )
        ],
      ),
    );
  }
}

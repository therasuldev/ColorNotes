import 'package:flutter/material.dart';
import 'package:smallnotes/note.dart';

class SettingsLogo extends NoteStatelessWidget {
  final Widget? child;
  final Color color;
  SettingsLogo({Key? key, required this.child, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 35,
      alignment: Alignment.center,
      margin: const EdgeInsets.only(left: 5),
      decoration: SettingsDecor(color: color),
      child: child,
    );
  }
}

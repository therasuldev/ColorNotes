import 'package:flutter/material.dart';
import 'package:smallnotes/note.dart';

class SettingsTile extends NoteStatelessWidget {
  final Widget? child;
  SettingsTile({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: size(context).width * .9,
      decoration: SettingsCard(),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: child,
    );
  }
}

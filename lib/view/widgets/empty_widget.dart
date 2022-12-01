import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../note.dart';

class EmptyWidget extends NoteStatelessWidget {
  EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Image.asset(
          Assets.img.empty.path,
          color: Theme.of(context).disabledColor,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:smallnotes/core/app/note.dart';

abstract class NoteStatelessWidget extends StatelessWidget {
  NoteStatelessWidget({Key? key}) : super(key: key);
  final note = Note();
}

abstract class NoteStatefulWidget extends StatefulWidget {
  NoteStatefulWidget({Key? key}) : super(key: key);
  final note = Note();
}

abstract class NoteState<B extends NoteStatefulWidget> extends State<B> {
  final note = Note();
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smallnotes/core/app/mixins/mixins.dart';
import 'package:smallnotes/note.dart';
import 'package:uuid/uuid.dart';

import '../../../core/provider/bloc/note/note_bloc.dart';
import '../../widgets/drawer_components.dart';
import 'text_form_field.dart/forms.dart';

class Home extends NoteStatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends NoteState<Home> with HomeMixin, AppMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _textNote!.isEmpty ? _firstAppBar(context) : _lastAppBar(),
      drawer: NoteDrawer(),
      body: _body(),
    );
  }

  Widget _body() {
    return GestureDetector(
      onTap: () => unfocus(),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              TitleForm(titleNoteController: titleNoteController),
              TextForm(
                textNoteController: textNoteController,
                noteLength: 1000 - _textNote!.length,
                onChanged: (text) => setState(() => _textNote = text),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar _firstAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        note.fmt(context, 'app.title'),
        style: GoogleFonts.rubikMoonrocks(fontSize: 20),
      ),
      actions: [
        IconButton(
          onPressed: () => AppRoute.toFavoritePG(context),
          icon: Icon(PhosphorIcons.heartBold, color: AppColors.red),
        )
      ],
    );
  }

  AppBar _lastAppBar() {
    return AppBar(
      actions: [
        IconButton(
          onPressed: selectColor,
          icon: Icon(Icons.color_lens, color: backgroundColor),
        ),
        IconButton(
          onPressed: selectTextColor,
          icon: Icon(Icons.colorize_sharp, color: textColor),
        ),
        IconButton(onPressed: close, icon: const Icon(Icons.close)),
        IconButton(onPressed: check, icon: const Icon(PhosphorIcons.check)),
      ],
    );
  }
}

mixin HomeMixin on NoteState<Home> implements AppMixin {
  final titleNoteController = TextEditingController();
  final textNoteController = TextEditingController();
  Color pickerColorBACKG = AppColors.brownLight;
  Color pickerColorTEXT = AppColors.brownLight;
  Color backgroundColor = AppColors.backg;
  Color? textColor = AppColors.black;
  String? _textNote = '';

  @override
  void dispose() {
    titleNoteController.dispose();
    textNoteController.dispose();
    super.dispose();
  }

  void changePickerForBackground(Color color) => setState(() {
        pickerColorBACKG = color;
        backgroundColor = pickerColorBACKG;
      });
  void changePickerForText(Color color) => setState(() {
        pickerColorTEXT = color;
        textColor = pickerColorTEXT;
      });

  selectColor() {
    final selectColor = note.fmt(context, 'select.background.color');
    final changeColor = note.fmt(context, 'change.color');
    return ViewUtils.bottomSheet(
      context: context,
      selectColor: selectColor,
      changeColor: changeColor,
      pickerColor: pickerColorBACKG,
      changePickerColor: changePickerForBackground,
    );
  }

  selectTextColor() {
    final selectColor = note.fmt(context, 'select.text.color');
    return ViewUtils.selectTextColorSheet(
      context: context,
      textColor: selectColor,
      pickerColor: pickerColorTEXT,
      changePickerColor: changePickerForText,
    );
  }

  void close() {
    titleNoteController.clear();
    textNoteController.clear();
    setState(() {
      _textNote = '';
      textColor = AppColors.black;
      backgroundColor = AppColors.backg;
    });
  }

  void check() async {
    final result = (titleNoteController.text.length >= 4 &&
        textNoteController.text.length >= 4 &&
        textNoteController.text.length <= 1000);

    if (result) {
      final bloc = BlocProvider.of<NotesBloc>(context);
      final model = NoteModel(
        titleNote: titleNoteController.text.trim(),
        textNote: textNoteController.text.trim(),
        dateCreate: DateFormat('yyyy.MM.dd').format(DateTime.now()),
        backgroundColor: backgroundColor.value,
        textColor: textColor!.value,
        isFavorite: false,
      );

      bloc.add(AddNote(key: const Uuid().v4(), model: model));
      titleNoteController.clear();
      textNoteController.clear();
      setState(() {
        _textNote = '';
        textColor = AppColors.black;
        backgroundColor = AppColors.backg;
      });
      unfocus();
    } else {
      final msg = note.fmt(context, 'error.snack');
      ViewUtils.showSnack(context, msg: msg, color: AppColors.red);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:smallnotes/core/app/mixins/mixins.dart';
import 'package:smallnotes/note.dart';
import 'package:smallnotes/view/general/home/home.dart';
import 'package:smallnotes/view/general/search/search.dart';

import 'all_notes/view_all_notes.dart';

class GeneralHome extends NoteStatefulWidget {
  GeneralHome({Key? key}) : super(key: key);

  @override
  State<GeneralHome> createState() => _GeneralHomeState();
}

class _GeneralHomeState extends NoteState<GeneralHome>
    with GeneralHomeMixin, AppMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (value) => pageChanged(value),
        children: [..._pages],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  BottomNavigationBar _bottomNavigationBar() {
    final noteAdd = note.fmt(context, 'bottom_navbar.note.add');
    final notes = note.fmt(context, 'bottom_navbar.notes');
    final search = note.fmt(context, 'search');
    return BottomNavigationBar(
      onTap: (int index) => bottomTapped(index),
      currentIndex: bottomSelectedIndex,
      items: [
        BottomNavigationBarItem(
            icon: const Icon(Icons.note_add), label: noteAdd),
        BottomNavigationBarItem(icon: const Icon(Icons.search), label: search),
        BottomNavigationBarItem(
            icon: const Icon(PhosphorIcons.note), label: notes),
      ],
    );
  }
}

mixin GeneralHomeMixin on NoteState<GeneralHome> implements AppMixin {
  int bottomSelectedIndex = 0;
  final pageController = PageController(initialPage: 0, keepPage: true);
  final _pages = <NoteStatefulWidget>[Home(), Search(), AllNotesView()];

  void pageChanged(int index) {
    setState(() => bottomSelectedIndex = index);
    if (bottomSelectedIndex > 0) {
      unfocus();
    }
  }

  void bottomTapped(int index) {
    setState(() {
      bottomSelectedIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
    });
  }
}

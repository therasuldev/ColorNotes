import 'package:flutter/material.dart';
import 'package:smallnotes/note.dart';
import 'package:smallnotes/view/widgets/widgets.dart';

// An item object for [PopUpMenuBar].
class PopUpMenuBarItem {
  final String title;
  final Widget tralling;

  const PopUpMenuBarItem({required this.title, required this.tralling});
}

// A modified pop up menu widget.
class PopUpMenuBar extends NoteStatelessWidget {
  final List<PopUpMenuBarItem> items;
  final Function(int index) onSelect;
  final IconData baseIcon;
  final BorderRadius radius;
  final Color iconColor;
  final BorderSide border;

  PopUpMenuBar({
    Key? key,
    required this.items,
    required this.onSelect,
    this.baseIcon = Icons.more_vert,
    this.radius = const BorderRadius.only(
      topLeft: Radius.circular(25),
      bottomLeft: Radius.circular(25),
      bottomRight: Radius.circular(25),
    ),
    this.iconColor = Colors.black,
    this.border = BorderSide.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        key: const Key('popUpMenuBar.widget'),
        shape: RoundedRectangleBorder(borderRadius: radius, side: border),
        icon: Icon(baseIcon, color: iconColor),
        onSelected: onSelect,
        itemBuilder: (context) => [
              for (var i = 0; i < items.length; i++)
                PopupMenuItem(
                  key: Key('popUpMenuItem.$i'),
                  value: i,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        items[i].tralling,
                        const SizedBox(width: 10),
                        Text(items[i].title),
                      ],
                    ),
                  ),
                )
            ],
        color: Theme.of(context).cardColor);
  }
}

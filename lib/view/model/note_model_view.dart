import 'package:custom_clippers/custom_clippers.dart';
import 'package:flutter/material.dart';

import '../../note.dart';

class NoteModelView extends NoteStatelessWidget {
  final NoteModel model;
  final List selectItems;
  final int index;
  NoteModelView(
      {Key? key,
      required this.model,
      required this.index,
      required this.selectItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visible = selectItems.contains(index);
    return Stack(
      children: [
        ClipPath(
          clipper: UpperNipMessageClipperTwo(MessageType.send),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
            padding: const EdgeInsets.symmetric(horizontal: 3),
            decoration: ItemCard(
                borderColor: AppColors.black.value,
                color: visible
                    ? AppColors.grey.withOpacity(.5).value
                    : model.backgroundColor),
            child: _noteModelElements(),
          ),
        ),
        Visibility(
          visible: visible,
          child: Align(
            alignment: Alignment.center,
            child: Icon(Icons.check, color: AppColors.black, size: 50),
          ),
        )
      ],
    );
  }

  Widget _noteModelElements() {
    final visible = selectItems.contains(index);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 200,
          height: 40,
          color: AppColors.transparent,
          alignment: Alignment.topLeft,
          child: Text(
            model.titleNote,
            style: textStyle(visible: visible, size: 17, fW: FontWeight.bold),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 5, right: 5),
          width: 200,
          height: 122,
          color: AppColors.transparent,
          child: Text(
            model.textNote,
            maxLines: 6,
            style: textStyle(visible: visible, size: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Container(
            width: 200,
            height: 27,
            color: AppColors.transparent,
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(right: 10),
            child: Text(
              model.dateCreate,
              maxLines: 1,
              style: textStyle(visible: visible, size: 16, fW: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  TextStyle textStyle({required bool visible, double? size, FontWeight? fW}) {
    return TextStyle(
      fontWeight: fW ?? FontWeight.normal,
      color: visible ? AppColors.white : Color(model.textColor),
      fontSize: size,
    );
  }
}

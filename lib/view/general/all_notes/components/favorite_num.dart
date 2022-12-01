import 'package:flutter/material.dart';
import 'package:smallnotes/note.dart';

class FavoriteNum extends NoteStatefulWidget {
  FavoriteNum({Key? key, required this.favoriteNum}) : super(key: key);
  final int favoriteNum;

  @override
  State<FavoriteNum> createState() => _FavoriteNumState();
}

class _FavoriteNumState extends State<FavoriteNum> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => AppRoute.toFavoritePG(context),
      child: Container(
        height: 55,
        width: 66,
        decoration: NumCard(context: context, color: AppColors.red),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Icons.favorite, color: AppColors.red),
            Text(
              widget.favoriteNum.toString(),
              style: TextStyle(color: AppColors.red),
            )
          ],
        ),
      ),
    );
  }
}

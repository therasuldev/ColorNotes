import 'package:flutter/material.dart';
import 'package:smallnotes/core/model/note_model.dart';
import 'package:smallnotes/view/general/general_home.dart';


import '../../view/general/all_notes/show_item.dart';
import '../../view/general/favorite_page/favorite.dart';
import '../../view/widgets/settings/settings.dart';
import 'animation_route/bottom_to_top.dart';
import 'animation_route/right_to_left_route.dart';

class AppRoute {
  static toShowItem(BuildContext context, String id, NoteModel model) {
    bTtRoute(
      context: context,
      route: ShowItem(id: id, model: model),
      back: true,
    );
  }

  static get toGeneralHome => GeneralHome();

  static toFavorite(BuildContext context) {
    bTtRoute(
      context: context,
      route: FavoritePG(),
      back: true,
    );
  }

  static toFavoritePG(BuildContext context) {
    rTlRoute(
      context: context,
      route: FavoritePG(),
      back: true,
    );
  }

  static toShowItemPG(BuildContext context, String id, NoteModel model) {
    rTlRoute(
      context: context,
      route: ShowItem(id: id, model: model),
      back: true,
    );
  }

  static toSettings(BuildContext context) {
    bTtRoute(
      context: context,
      route: Settings(),
      back: true,
    );
  }
}

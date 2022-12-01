import 'package:hive_flutter/hive_flutter.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  final String titleNote;
  @HiveField(1)
  final String textNote;
  @HiveField(2)
  final String dateCreate;
  @HiveField(3)
  final int backgroundColor;
  @HiveField(4)
  final int textColor;
  @HiveField(5)
  bool isFavorite;

  NoteModel({
    required this.titleNote,
    required this.textNote,
    required this.dateCreate,
    required this.backgroundColor,
    required this.textColor,
    required this.isFavorite,
  });
}

import 'package:flutter/material.dart';

import '../../note.dart';

class Themes {
  static const lightID = 'light';
  static const darkID = 'dark';

  ThemeData get light => ThemeData(
      highlightColor: AppColors.grey.withOpacity(.1),
      dividerColor: AppColors.black,
      scaffoldBackgroundColor: AppColors.white,
      primaryColor: AppColors.white,
      iconTheme: IconThemeData(color: AppColors.black),
      appBarTheme: AppBarTheme(
        elevation: 0.5,
        backgroundColor: AppColors.brownLight,
        iconTheme: IconThemeData(color: AppColors.brown),
        titleTextStyle: TextStyle(color: AppColors.brown, fontSize: 18),
      ),
      primaryTextTheme: TextTheme(
        bodyText1: TextStyle(color: AppColors.brown),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.black,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.selectedColor,
        unselectedItemColor: AppColors.grey,
      ),
      cardTheme: CardTheme(color: AppColors.white),
      cardColor: AppColors.brownLight,
      textTheme: TextTheme(
          headline6: TextStyle(color: AppColors.black),
          subtitle1: TextStyle(color: AppColors.black)),
      hintColor: AppColors.brown);

  ThemeData get dark => ThemeData(
        highlightColor: AppColors.grey.withOpacity(.7),
        scaffoldBackgroundColor: AppColors.background,
        iconTheme: IconThemeData(color: AppColors.white),
        colorScheme: ColorScheme.dark(primary: AppColors.white),
        appBarTheme: AppBarTheme(
          elevation: 1,
          color: AppColors.background,
          titleTextStyle: TextStyle(color: AppColors.brown200, fontSize: 18),
          actionsIconTheme: IconThemeData(color: AppColors.white),
          iconTheme: IconThemeData(color: AppColors.brown200),
        ),
        primaryTextTheme: const TextTheme(
          bodyText1: TextStyle(
            color: Color.fromARGB(221, 33, 33, 33),
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.white,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColors.selectedColor,
          unselectedItemColor: AppColors.white.withOpacity(.5),
        ),
        cardTheme: const CardTheme(color: Color.fromARGB(255, 201, 201, 201)),
        cardColor: const Color.fromARGB(255, 162, 162, 162),
        textTheme: TextTheme(
            headline6: const TextStyle(color: Colors.grey),
            subtitle1: TextStyle(color: AppColors.background)),
        hintColor: AppColors.grey,
      );
}

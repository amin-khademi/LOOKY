import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color color = Color(0xff292d32);
  static const Color color1 = Color(0xffffffff);
  static const Color color2 = Color(0xff1F2A40);
  static const Color color3 = Color(0xff8A95ABCC);
  static const Color color4 = Color(0xff808A9E);
  static const Color color5 =  Color(0xff6440FE);
  static const Color color6 =  Color(0xffAA935F);
  static const Color color7 = Color(0xffC7CDD9);
}

class AppShadow {
  static BoxShadow shadow1 = BoxShadow(
    color: Colors.black.withOpacity(0.1),
    spreadRadius: 0,
    blurRadius: 11,
    offset: const Offset(0, 0), // changes position of shadow
  );
}

class AppThemes {
  static const TextStyle lightBaseTextStyle =
      TextStyle(color: AppColors.color1, fontFamily: 'DMSans');
  static final ThemeData lightTheme = ThemeData(
    dividerColor: AppColors.color,
    scaffoldBackgroundColor: AppColors.color2,
    textTheme: TextTheme(
      displayLarge: lightBaseTextStyle.copyWith(
          fontSize: 50, fontWeight: FontWeight.w700),
      bodyMedium: lightBaseTextStyle.copyWith(
          fontSize: 15, fontWeight: FontWeight.w700),
      displayMedium: lightBaseTextStyle.copyWith(
          fontSize: 24, fontWeight: FontWeight.bold),
      headlineSmall: lightBaseTextStyle.copyWith(
          fontSize: 16, fontWeight: FontWeight.w400),
      titleLarge: lightBaseTextStyle.copyWith(
          fontSize: 16, fontWeight: FontWeight.bold),
      titleMedium: lightBaseTextStyle.copyWith(
          fontSize: 36, fontWeight: FontWeight.w400),
      titleSmall:
          lightBaseTextStyle.copyWith(fontSize: 8, fontWeight: FontWeight.bold),
      bodyLarge: lightBaseTextStyle.copyWith(
          fontSize: 20, fontWeight: FontWeight.bold),
    ),
    iconTheme: const IconThemeData(color: AppColors.color),
  );
}

class AppImages {
  static const String _base = "assets/img";
  static const String slider = "$_base/slider.png";
  static const String cut = "$_base/cut.png";
}

class AppIcons {
  static const String _base = "assets/icons";
  static const String icLauncher = "$_base/ic_launcher.png";

  // SVG icons
  static const String icBlueTick = "$_base/blue_tick.svg";
  static const String icBookmark = "$_base/bookmark.svg";
  static const String icCut = "$_base/cut.svg";
  static const String icCut2 = "$_base/cut2.svg";
  static const String icFilter = "$_base/filter.svg";
  static const String icGroup133 = "$_base/Group 133.svg";
  static const String icGroup136 = "$_base/Group136.svg";
  static const String icHome = "$_base/home.svg";
  static const String icLoc = "$_base/loc.svg";
  static const String icLocation = "$_base/location.svg";
  static const String icNearby = "$_base/nearby.svg";
  static const String icSearch = "$_base/search.svg";
  static const String icShave = "$_base/shave.svg";
  static const String icStar = "$_base/star.svg";
  static const String icUser = "$_base/user.svg";
  
}

class AppAnimations {
  static const String _base = "assets/gifs";
  static const String empty = "$_base/Animation.json";
}

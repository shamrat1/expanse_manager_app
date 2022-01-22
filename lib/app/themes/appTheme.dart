import 'package:flutter/material.dart';

// hemeData(
//           appBarTheme: Theme.of(context)
//               .appBarTheme
//               .copyWith(brightness: Brightness.light),
//           primarySwatch: Colors.red,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//           primaryColor: Color(0xffffffff),
//           primaryColorDark: Colors.black45,
//           accentColor: Color(0xffcc0844),
//           scaffoldBackgroundColor: Colors.white,
//           secondaryHeaderColor: Colors.white,
//           hintColor: Colors.grey,
//           textTheme: TextTheme(bodyText2: TextStyle(color: Color(0xffcc0844))),
//         ),
class AppTheme {
  AppTheme._();

  static Color _iconColor = Colors.black87;

  static const Color _lightPrimaryColor = Colors.white;
  static const Color _lightPrimaryVariantColor = Colors.white;
  static const Color _lightSecondaryColor = Color(0xffcc0844);
  static const Color _lightSecondaryColorLowShade = Color(0x55cc0844);
  static const Color _lightOnPrimaryColor = Colors.black;
  static const Color _lightDividerColor = Colors.grey;
  static const Color _lightBodyColor = Color(0xff7e7e7e);
  // static const Color _lightDividerColor = Color(0x29000000);
  static const Color _lightShadowColor = Color(0x29000000);

  static const Color _darkPrimaryColor = Colors.white24;
  static const Color _darkPrimaryVariantColor = Colors.black;
  static const Color _darkSecondaryColor = Colors.white;
  static const Color _darkOnPrimaryColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    fontFamily: "Poppins",
    scaffoldBackgroundColor: _lightPrimaryVariantColor,
    accentColor: _lightSecondaryColor,
    dividerColor: _lightDividerColor,
    backgroundColor: _lightPrimaryColor,
    shadowColor: _lightShadowColor,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: _lightSecondaryColorLowShade,
      selectionHandleColor: _lightSecondaryColor,
    ),
    appBarTheme: AppBarTheme(
        color: _lightPrimaryVariantColor,
        iconTheme: IconThemeData(color: _lightOnPrimaryColor),
        textTheme: _lightTextTheme),
    colorScheme: ColorScheme.light(
      primary: _lightPrimaryColor,
      primaryVariant: _lightPrimaryVariantColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
    ),
    iconTheme: IconThemeData(
      color: _iconColor,
    ),
    textTheme: _lightTextTheme,
  );

  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkPrimaryVariantColor,
    appBarTheme: AppBarTheme(
        color: _darkPrimaryVariantColor,
        iconTheme: IconThemeData(color: _darkOnPrimaryColor),
        textTheme: _darkTextTheme),
    colorScheme: ColorScheme.light(
      primary: _darkPrimaryColor,
      primaryVariant: _darkPrimaryVariantColor,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
    ),
    iconTheme: IconThemeData(
      color: _iconColor,
    ),
    textTheme: _darkTextTheme,
  );

  static final TextTheme _lightTextTheme = TextTheme(
    headline1: _lightScreenHeadingTextStyle,
    headline2: _lightScreenHeadingTextStyle2,
    headline3: _lightScreenHeadingTextStyle3,
    bodyText1: _lightScreenBodyTextStyle1,
    bodyText2: _lightScreenTaskDurationTextStyle,
  );

  static final TextTheme _darkTextTheme = TextTheme(
    headline1: _darkScreenHeadingTextStyle,
    headline2: _darkScreenHeadingTextStyle,
    headline3: _darkScreenHeadingTextStyle,
    headline4: _darkScreenHeadingTextStyle,
    headline5: _darkScreenHeadingTextStyle,
    headline6: _darkScreenHeadingTextStyle,
    subtitle1: _darkScreenHeadingTextStyle,
    subtitle2: _darkScreenHeadingTextStyle,
    bodyText1: _darkScreenTaskNameTextStyle,
    bodyText2: _darkScreenTaskNameTextStyle,
  );

  static final TextStyle _lightScreenHeadingTextStyle =
      TextStyle(fontSize: 32.0, color: _lightOnPrimaryColor);

  static final TextStyle _lightScreenHeadingTextStyle2 =
      TextStyle(fontSize: 24.0, color: _lightOnPrimaryColor);

  static final TextStyle _lightScreenHeadingTextStyle3 = TextStyle(
    fontSize: 14,
    color: _lightOnPrimaryColor,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle _lightScreenBodyTextStyle1 = TextStyle(
    fontSize: 12,
    color: _lightBodyColor,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle _lightScreenTaskNameTextStyle =
      TextStyle(fontSize: 14.0, color: _lightOnPrimaryColor);
  static final TextStyle _lightScreenTaskDurationTextStyle =
      TextStyle(fontSize: 12.0, color: Colors.grey);

  static final TextStyle _darkScreenHeadingTextStyle =
      _lightScreenHeadingTextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenTaskNameTextStyle =
      _lightScreenTaskNameTextStyle.copyWith(color: _darkOnPrimaryColor);

  static final TextStyle _darkScreenTaskDurationTextStyle =
      _lightScreenTaskDurationTextStyle;
}

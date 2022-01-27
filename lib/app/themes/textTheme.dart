import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

// This uses the MaterialBasedCupertinoThemeData mechs so that
// we have one base text theme for both Material and Cupertino widgets
TextTheme myBaseTextTheme = TextTheme(
  headline1: myHeadline1,
  headline2: myHeadline2,
  headline3: myHeadline3,
  headline4: myHeadline4,
  headline5: myHeadline5,
  headline6: myHeadline6,
  subtitle1: mySubtitle1,
  subtitle2: mySubtitle2,
  bodyText1: myBodytext1,
  bodyText2: myBodytext2,
  caption: myCaption,
  button: myButton,
  overline: myOverline,
);

TextStyle myHeadline1 = const TextStyle(
  // ignore: avoid_redundant_argument_values
  fontFamily: "Poppins",
  inherit: true,
  fontSize: 96,
  fontWeight: FontWeight.w300,
  fontStyle: FontStyle.normal,
  letterSpacing: -1.5,
  textBaseline: TextBaseline.alphabetic,
  leadingDistribution: TextLeadingDistribution.even,
  debugLabel: 'Headline1',
  overflow: TextOverflow.fade,
);

TextStyle myHeadline2 = const TextStyle(
  fontFamily: "Poppins",

  // ignore: avoid_redundant_argument_values
  inherit: true,
  fontSize: 60,
  fontWeight: FontWeight.w300,
  fontStyle: FontStyle.normal,
  letterSpacing: -0.5,
  textBaseline: TextBaseline.alphabetic,
  leadingDistribution: TextLeadingDistribution.even,
  debugLabel: 'Headline2',
  overflow: TextOverflow.fade,
);

TextStyle myHeadline3 = const TextStyle(
  // ignore: avoid_redundant_argument_values
  fontFamily: "Poppins",
  inherit: true,
  fontSize: 48,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  letterSpacing: 0.0,
  textBaseline: TextBaseline.alphabetic,
  leadingDistribution: TextLeadingDistribution.even,
  debugLabel: 'Headline3',
  overflow: TextOverflow.fade,
);

TextStyle myHeadline4 = const TextStyle(
  // ignore: avoid_redundant_argument_values
  fontFamily: "Poppins",
  inherit: true,
  fontSize: 34,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  letterSpacing: 0.25,
  textBaseline: TextBaseline.alphabetic,
  leadingDistribution: TextLeadingDistribution.even,
  debugLabel: 'Headline4',
  overflow: TextOverflow.fade,
);

TextStyle myHeadline5 = const TextStyle(
  // ignore: avoid_redundant_argument_values
  fontFamily: "Poppins",
  inherit: true,
  fontSize: 24,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  letterSpacing: 0.0,
  textBaseline: TextBaseline.alphabetic,
  leadingDistribution: TextLeadingDistribution.even,
  debugLabel: 'Headline5',
  overflow: TextOverflow.fade,
);

TextStyle myHeadline6 = const TextStyle(
  // ignore: avoid_redundant_argument_values
  fontFamily: "Poppins",
  inherit: true,
  fontSize: 20,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.normal,
  letterSpacing: 0.15,
  textBaseline: TextBaseline.alphabetic,
  leadingDistribution: TextLeadingDistribution.even,
  debugLabel: 'Headline6',
  overflow: TextOverflow.fade,
);

TextStyle mySubtitle1 = const TextStyle(
  // ignore: avoid_redundant_argument_values
  fontFamily: "Poppins",
  inherit: true,
  fontSize: 16,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  letterSpacing: 0.15,
  textBaseline: TextBaseline.alphabetic,
  leadingDistribution: TextLeadingDistribution.even,
  debugLabel: 'Subtitle1',
  overflow: TextOverflow.fade,
);

TextStyle mySubtitle2 = const TextStyle(
  // ignore: avoid_redundant_argument_values
  fontFamily: "Poppins",
  inherit: true,
  fontSize: 14,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.normal,
  letterSpacing: 0.1,
  textBaseline: TextBaseline.alphabetic,
  leadingDistribution: TextLeadingDistribution.even,
  debugLabel: 'Subtitle2',
  overflow: TextOverflow.fade,
);
TextStyle myBodytext1 = const TextStyle(
  // ignore: avoid_redundant_argument_values
  fontFamily: "Poppins",
  inherit: true,
  fontSize: 16,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  letterSpacing: 0.5,
  textBaseline: TextBaseline.alphabetic,
  leadingDistribution: TextLeadingDistribution.even,
  debugLabel: 'Bodytext1',
  overflow: TextOverflow.fade,
);

TextStyle myBodytext2 = const TextStyle(
  // ignore: avoid_redundant_argument_values
  fontFamily: "Poppins",
  inherit: true,
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  letterSpacing: 0.25,
  textBaseline: TextBaseline.alphabetic,
  leadingDistribution: TextLeadingDistribution.even,
  debugLabel: 'Bodytext2',
  overflow: TextOverflow.fade,
);

TextStyle myCaption = const TextStyle(
  // ignore: avoid_redundant_argument_values
  fontFamily: "Poppins",
  inherit: true,
  fontSize: 12,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  letterSpacing: 0.4,
  textBaseline: TextBaseline.alphabetic,
  leadingDistribution: TextLeadingDistribution.even,
  debugLabel: 'Caption',
  overflow: TextOverflow.fade,
);

TextStyle myButton = const TextStyle(
  // ignore: avoid_redundant_argument_values
  fontFamily: "Poppins",
  inherit: true,
  fontSize: 14,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.normal,
  letterSpacing: 1.25,
  textBaseline: TextBaseline.alphabetic,
  leadingDistribution: TextLeadingDistribution.even,
  debugLabel: 'Button',
  overflow: TextOverflow.fade,
);

TextStyle myOverline = const TextStyle(
  // ignore: avoid_redundant_argument_values
  fontFamily: "Poppins",
  inherit: true,
  fontSize: 10,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  letterSpacing: 1.5,
  textBaseline: TextBaseline.alphabetic,
  leadingDistribution: TextLeadingDistribution.even,
  debugLabel: 'Overline',
  overflow: TextOverflow.fade,
);

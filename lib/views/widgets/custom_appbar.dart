import 'package:flutter/material.dart';

AppBar getCustomAppBar({required String title, Widget? rightIconButton}) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
    actions: [
      rightIconButton ?? Container(),
    ],
  );
}

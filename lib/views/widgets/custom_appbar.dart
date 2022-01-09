import 'package:flutter/material.dart';

AppBar getCustomAppBar({
  required String title,
}) {
  return AppBar(
    title: Text(title),
    centerTitle: true,
  );
}

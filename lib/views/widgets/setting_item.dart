import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingItem extends StatefulWidget {
  const SettingItem({Key? key, required this.onTap, required this.title}) : super(key: key);
  final VoidCallback onTap;
  final String title;

  @override
  _SettingItemState createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  @override
  Widget build(BuildContext context) {
    return                         InkWell(
      onTap: widget.onTap,
      child: FittedBox(
        child: Container(

          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: Color(0xffdbdbdb)))),
          alignment: Alignment.center,
          // color: Colors.amber,
          child: Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

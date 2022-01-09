import 'dart:math';

import 'package:expanse_manager/views/widgets/custom_appbar.dart';
import 'package:expanse_manager/views/widgets/todo_item_tile.dart';
import 'package:flutter/material.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: "Todo's"),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: TodoItemTile(
                isCompleted: i % 2 == 0 ? true : false,
              ),
            );
          },
        ),
      ),
    );
  }
}

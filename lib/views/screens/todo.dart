import 'dart:math';

import 'package:expanse_manager/app/controllers/TodoController.dart';
import 'package:expanse_manager/views/widgets/custom_appbar.dart';
import 'package:expanse_manager/views/widgets/paperfly_loading.dart';
import 'package:expanse_manager/views/widgets/todo_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TodoController controller = Get.put(TodoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getCustomAppBar(title: "Todo's"),
      body: Obx(
        () => Padding(
          padding: EdgeInsets.all(8.0),
          child: Stack(
            children: [
              ListView.builder(
                itemCount: controller.todos.value.length,
                itemBuilder: (context, i) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: TodoItemTile(
                      todo: controller.todos[i],
                      isCompleted:
                          controller.todos[i].completed == 0 ? false : true,
                    ),
                  );
                },
              ),
              if (controller.loading.value) EMLoading(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => controller.getToNewTodoPage(),
        child: Icon(Icons.add_rounded),
      ),
    );
  }
}

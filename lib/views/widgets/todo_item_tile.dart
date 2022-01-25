import 'package:expanse_manager/app/extensions/color_extension.dart';
import 'package:expanse_manager/app/models/TodoResponse.dart';
import 'package:flutter/material.dart';

class TodoItemTile extends StatelessWidget {
  const TodoItemTile({Key? key, required this.isCompleted, required this.todo})
      : super(key: key);
  final bool isCompleted;
  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: isCompleted
              ? Colors.grey.withOpacity(0.5)
              : Colors.greenAccent.withOpacity(0.7),
        ),
      ),
      title: Text(
        todo.task.toString(),
        style: TextStyle(
          decoration: isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: todo.categoryId != null
          ? Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: todo.category?.color != null
                        ? HexColor.fromHex(todo.category?.color ?? "ffffff")
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    todo.category?.name ?? "",
                    style: TextStyle(fontSize: 9),
                  ),
                ),
              ],
            )
          : Container(),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.check_circle_outline_rounded,
          color: isCompleted
              ? Theme.of(context).colorScheme.secondary
              : Colors.grey,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TodoItemTile extends StatelessWidget {
  const TodoItemTile({Key? key, required this.isCompleted}) : super(key: key);
  final bool isCompleted;

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
        "Something",
        style: TextStyle(
          decoration: isCompleted ? TextDecoration.lineThrough : null,
        ),
      ),
      subtitle: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 3,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              "Cate",
              style: TextStyle(fontSize: 9),
            ),
          ),
        ],
      ),
      trailing: Icon(Icons.check_circle_outline_rounded),
    );
  }
}

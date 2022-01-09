import 'package:flutter/material.dart';

enum TransactionType { INCOME, EXPANSE }

class TransactionItemTile extends StatelessWidget {
  const TransactionItemTile({
    Key? key,
    required this.type,
  }) : super(key: key);
  final TransactionType type;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(
          color: this.type == TransactionType.EXPANSE
              ? Colors.red.withOpacity(0.7)
              : Colors.blue.withOpacity(0.7),
        ),
      ),
      title: const Text("Something"),
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
      trailing: const Text(
        "3 Days Ago",
        style: TextStyle(color: Color(0xffdbdbdb)),
      ),
    );
  }
}

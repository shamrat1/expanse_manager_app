import 'package:expanse_manager/app/extensions/color_extension.dart';
import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:expanse_manager/app/models/TransactionResponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum TransactionType { INCOME, EXPANSE }

class TransactionItemTile extends StatelessWidget {
  const TransactionItemTile({
    Key? key,
    required this.type,
    required this.transaction,
  }) : super(key: key);
  final TransactionType type;
  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Get.snackbar(
        type == TransactionType.EXPANSE ? "Expense" : "Income",
        transaction.description ?? 'N/A',
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      style: ListTileStyle.drawer,
      shape: RoundedRectangleBorder(

        borderRadius: BorderRadius.circular(10),

        side: BorderSide(
          color: this.type == TransactionType.EXPANSE
              ? Colors.red.withOpacity(0.3)
              : Colors.blue.withOpacity(0.3),
        ),
      ),
      title: Text(transaction.amount.toString()),
      subtitle: transaction.categoryId != null
          ? Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 3,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: transaction.category?.color != null
                        ? HexColor.fromHex(
                            transaction.category?.color ?? "ffffff")
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    transaction.category?.name ?? "",
                    style: TextStyle(fontSize: 9),
                  ),
                ),
              ],
            )
          : Container(),
      trailing: Text(
        getFormattedDate(transaction.entryDate!),
        style: TextStyle(color: Color(0xffdbdbdb)),
      ),
    );
  }
}

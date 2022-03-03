import 'package:expanse_manager/app/controllers/TransactionsController.dart';
import 'package:expanse_manager/views/widgets/custom_appbar.dart';
import 'package:expanse_manager/views/widgets/paperfly_loading.dart';
import 'package:expanse_manager/views/widgets/transaction_item_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  TransactionsController controller = Get.put(TransactionsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: getCustomAppBar(
              title: "Transactions",
              rightIconButton: IconButton(
                  onPressed: () => controller.printPDF(),
                  icon: const Icon(Icons.print))),
          floatingActionButton: FloatingActionButton(
            onPressed: () => controller.getAllTransactions(controller.type),
            child: const Icon(Icons.add),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: TabBar(
                      controller: controller.tabController,
                      tabs: controller.tabs,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: controller.tabController,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              itemCount: controller.expenses.length,
                              itemBuilder: (context, i) {
                                // return Container();
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: TransactionItemTile(
                                    type: TransactionType.EXPANSE,
                                    transaction: controller.expenses[i],
                                  ),
                                );
                              }),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                              itemCount: controller.incomes.length,
                              itemBuilder: (context, i) {
                                // return Container();
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: TransactionItemTile(
                                    type: TransactionType.INCOME,
                                    transaction: controller.incomes[i],
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (controller.loading.value) const EMLoading(),
            ],
          ),
        ));
  }
}

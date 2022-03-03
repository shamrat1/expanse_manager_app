import 'package:expanse_manager/app/models/TransactionResponse.dart';
import 'package:expanse_manager/app/services/TransactionService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransactionsController extends GetxController
    with GetTickerProviderStateMixin {
  TabController? tabController;
  List<Tab> tabs = const [Tab(text: "Expense"), Tab(text: "Expense")];

  RxBool loading = false.obs;
  RxList<Transaction> expenses = <Transaction>[].obs;
  RxList<Transaction> incomes = <Transaction>[].obs;
  String type = "expense";
  TransactionResponse expenseResponse = TransactionResponse();
  TransactionResponse incomeResponse = TransactionResponse();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController!.addListener(() {
      type = tabController!.index == 0 ? "expense" : "income";
    });
    getAllTransactions("expense");
  }

  void printPDF() {}

  void getAllTransactions(String type) async {
    // if (type == "expense") {
    loading(true);
    expenseResponse = await TransactionService().getExpanses();
    expenses.value = [];
    expenses.value = expenseResponse.transactions!;
    // } else {
    incomeResponse = await TransactionService().getIncomes();
    incomes.value = [];
    incomes.value = incomeResponse.transactions!;
    // }
    loading(false);
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }
}

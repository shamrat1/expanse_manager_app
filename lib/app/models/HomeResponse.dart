// To parse this JSON data, do
//
//     final homeResponse = homeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:expanse_manager/app/models/TransactionResponse.dart';

HomeResponse homeResponseFromJson(String str) =>
    HomeResponse.fromJson(json.decode(str));

String homeResponseToJson(HomeResponse data) => json.encode(data.toJson());

class HomeResponse {
  HomeResponse({
    this.incomeTotal,
    this.expenseTotal,
    this.recentExpenses,
    this.expenseArray,
  });

  String? incomeTotal;
  int? expenseTotal;
  List<Transaction>? recentExpenses;
  List<String>? expenseArray;

  factory HomeResponse.fromJson(Map<String, dynamic> json) => HomeResponse(
        incomeTotal: (json["incomeTotal"]).toString(),
        expenseTotal: json["expenseTotal"],
        recentExpenses: List<Transaction>.from(
            json["recentExpenses"].map((x) => Transaction.fromJson(x))),
        expenseArray: List<String>.from(json["expenseArray"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "incomeTotal": incomeTotal,
        "expenseTotal": expenseTotal,
        "recentExpenses":
            List<dynamic>.from(recentExpenses!.map((x) => x.toJson())),
        "expenseArray": List<dynamic>.from(expenseArray!.map((x) => x)),
      };
}

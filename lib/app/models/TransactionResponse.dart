// To parse this JSON data, do
//
//     final transactionResponse = transactionResponseFromJson(jsonString);

import 'dart:convert';

import 'package:expanse_manager/app/models/CategoryResponse.dart';

TransactionResponse transactionResponseFromJson(String str) =>
    TransactionResponse.fromJson(json.decode(str));

String transactionResponseToJson(TransactionResponse data) =>
    json.encode(data.toJson());

class TransactionResponse {
  TransactionResponse({
    this.currentPage,
    this.transactions,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<Transaction>? transactions;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic? prevPageUrl;
  int? to;
  int? total;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      TransactionResponse(
        currentPage: json["current_page"],
        transactions: List<Transaction>.from(
            json["data"].map((x) => Transaction.fromJson(x))),
        firstPageUrl: json["first_page_url"],
        from: json["from"],
        lastPage: json["last_page"],
        lastPageUrl: json["last_page_url"],
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        nextPageUrl: json["next_page_url"],
        path: json["path"],
        perPage: json["per_page"],
        prevPageUrl: json["prev_page_url"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "data": List<dynamic>.from(transactions!.map((x) => x.toJson())),
        "first_page_url": firstPageUrl,
        "from": from,
        "last_page": lastPage,
        "last_page_url": lastPageUrl,
        "links": List<dynamic>.from(links!.map((x) => x.toJson())),
        "next_page_url": nextPageUrl,
        "path": path,
        "per_page": perPage,
        "prev_page_url": prevPageUrl,
        "to": to,
        "total": total,
      };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  dynamic label;
  bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}

class Transaction {
  Transaction({
    this.id,
    this.entryDate,
    this.amount,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.categoryId,
    this.createdById,
    this.category,
    this.createdBy,
  });

  int? id;
  DateTime? entryDate;
  String? amount;
  dynamic description;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? categoryId;
  dynamic createdById;
  Category? category;
  dynamic createdBy;

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        entryDate: DateTime.parse(json["entry_date"]),
        amount: json["amount"],
        description: json["description"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        categoryId: json["category_id"],
        createdById: json["created_by_id"],
        category: json['category'] != null
            ? Category.fromJson(json["category"])
            : null,
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "entry_date":
            "${entryDate!.year.toString().padLeft(4, '0')}-${entryDate!.month.toString().padLeft(2, '0')}-${entryDate!.day.toString().padLeft(2, '0')}",
        "amount": amount,
        "description": description,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
        "deleted_at": deletedAt,
        "category_id": categoryId,
        "created_by_id": createdById,
        "category": category!.toJson(),
        "created_by": createdBy,
      };
}

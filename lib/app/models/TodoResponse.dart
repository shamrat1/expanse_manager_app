// To parse this JSON data, do
//
//     final todoResponse = todoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:expanse_manager/app/models/CategoryResponse.dart';

TodoResponse todoResponseFromJson(String str) =>
    TodoResponse.fromJson(json.decode(str));

String todoResponseToJson(TodoResponse data) => json.encode(data.toJson());

class TodoResponse {
  TodoResponse({
    this.currentPage,
    this.todos,
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
  List<Todo>? todos;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Link>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  factory TodoResponse.fromJson(Map<String, dynamic> json) => TodoResponse(
        currentPage: json["current_page"],
        todos: List<Todo>.from(json["data"].map((x) => Todo.fromJson(x))),
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
        "data": List<dynamic>.from(todos!.map((x) => x.toJson())),
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
        "url": url == null ? null : url,
        "label": label,
        "active": active,
      };
}

class Todo {
  Todo(
      {this.id,
      this.categoryId,
      this.task,
      this.note,
      this.reminderAt,
      this.createdById,
      this.createdAt,
      this.updatedAt,
      this.category,
      this.completed});

  int? id;
  int? categoryId;
  String? task;
  dynamic note;
  DateTime? reminderAt;
  int? createdById;
  dynamic createdAt;
  dynamic updatedAt;
  Category? category;
  int? completed;

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        categoryId: json["category_id"],
        task: json["task"],
        note: json["note"],
        reminderAt: DateTime.parse(json["reminder_at"]),
        createdById: json["created_by_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        completed: json["completed"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "task": task,
        "note": note,
        "reminder_at": reminderAt!.toIso8601String(),
        "created_by_id": createdById,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "completed": completed,
        "category": category == null ? null : category!.toJson(),
      };
}

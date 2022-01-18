import 'dart:convert';

import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:expanse_manager/app/models/CategoryResponse.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class TransactionCategoryService {
  Future<List<Category>> getTransactionCategory(String type) async {
    var url = rootURL + "$type-categories";
    print(url);

    var response = await http.get(Uri.parse(url), headers: await _getHeader());

    if (response.statusCode == 200) {
      return List<Category>.from(
          (jsonDecode(response.body)["data"]).map((x) => Category.fromJson(x)));
    }
    print(response.statusCode);
    print(response.body);
    throw Exception("Error");
  }

  Future<Map<String, String>> _getHeader() async {
    var box = await Hive.openBox(hiveBox);
    var token = box.get(authToken);
    return {
      "accept": "application/json",
      "Authorization": "Bearer " + token,
    };
  }
}

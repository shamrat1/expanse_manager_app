import 'dart:convert';

import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:expanse_manager/app/models/CategoryResponse.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  Future<CategoryResponse> getCategoryResponse(
      {String? type, int page = 1}) async {
    var typeStr = "";
    if (type != null) {
      typeStr = "type=$type";
    }
    var url = rootURL + "categories?page=$page&$typeStr";

    var response = await http.get(Uri.parse(url), headers: await _getHeader());

    if (response.statusCode == 200) {
      return CategoryResponse.fromJson(jsonDecode(response.body));
    }

    throw Exception("Error");
  }

  Future<http.Response> storeCategories(Map<String, String> data,
      {int? id}) async {
    print(id);
    var url = rootURL + "categories" + (id != null ? "/$id" : "");
    print(url);
    http.Response response;
    if (id != null) {
      response = await http.patch(Uri.parse(url),
          headers: await _getHeader(), body: data);
    } else {
      response = await http.post(Uri.parse(url),
          headers: await _getHeader(), body: data);
    }

    print(response.statusCode);
    return response;
  }

  Future<http.Response> deleteCategory(int id) async {
    print(id);
    var url = rootURL + "categories/$id";
    print(url);
    var response = await http.delete(
      Uri.parse(url),
      headers: await _getHeader(),
    );
    print(response.statusCode);
    return response;
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

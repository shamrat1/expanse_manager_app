import 'package:expanse_manager/app/models/TransactionResponse.dart';
import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class TransactionService {
  Future<TransactionResponse> getExpanses({int page = 1}) async {
    var url = rootURL + "expenses?page=$page";
    var response = await http.get(Uri.parse(url), headers: await _getHeader());
    if (response.statusCode == 200) {
      return transactionResponseFromJson(response.body);
    }
    throw Exception("Error");
  }

  Future<TransactionResponse> getIncomes({int page = 1}) async {
    var url = rootURL + "incomes?page=$page";
    var response = await http.get(Uri.parse(url), headers: await _getHeader());
    if (response.statusCode == 200) {
      return transactionResponseFromJson(response.body);
    }
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

  Future<http.Response> postTransaction(
    Map<String, dynamic> data, {
    bool income = false,
  }) async {
    var url = rootURL + (income ? "incomes" : "expenses");
    var response = await http.post(
      Uri.parse(url),
      headers: await _getHeader(),
      body: data,
    );
    return response;
  }

  Future<http.Response> putTransaction(Map<String, dynamic> data, int id,
      {bool income = false}) async {
    var url = rootURL + (income ? "incomes" : "expenses") + "/$id";
    var response = await http.post(
      Uri.parse(url),
      headers: await _getHeader(),
      body: data,
    );
    return response;
  }

  Future<http.Response> deleteTransaction(int id, {bool income = false}) async {
    var url = rootURL + (income ? "incomes" : "expenses") + "/$id";
    var response = await http.delete(
      Uri.parse(url),
      headers: await _getHeader(),
    );
    return response;
  }
}

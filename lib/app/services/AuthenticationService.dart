import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:http/http.dart' as http;

class AuthenticationService {
  Future<http.Response> signin(Map<String, dynamic> data) {
    var url = rootURL + "/login";
    return http.post(Uri.parse(url), body: data);
  }

  Future<http.Response> register(Map<String, dynamic> data) {
    var url = rootURL + "/register";
    return http.post(Uri.parse(url), body: data);
  }
}

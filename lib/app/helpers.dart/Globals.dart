import 'package:intl/intl.dart';

// var rootURL = "http://192.168.31.205:8000/api/v1/";

var rootURL = "http://192.168.1.78/expanse-manager/public/api/v1/";
var authUserKey = "authenticated-user";
var isauthKey = 'isAuthenticated';
var authToken = 'auth-token';
var hiveBox = 'app';

String getFormattedDate(DateTime dateTime) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  return dateFormat.format(dateTime);
}

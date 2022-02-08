import 'package:intl/intl.dart';

var rootURL = "http://192.168.1.79/expanse-manager/public/api/v1/";
// var rootURL = "http://192.168.31.205/expanse_manager_backend/public/api/v1/";
var authUserKey = "authenticated-user";
var isauthKey = 'isAuthenticated';
var authToken = 'auth-token';
var hiveBox = 'app';
var themeKey = 'themeKey';

String getFormattedDate(DateTime dateTime) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  return dateFormat.format(dateTime);
}

String getFormattedDateTime(DateTime dateTime) {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd hh:mm a");
  return dateFormat.format(dateTime);
}

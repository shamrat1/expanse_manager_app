import 'package:intl/intl.dart';

var rootURL = "http://em.onplay365.in/api/v1/";
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

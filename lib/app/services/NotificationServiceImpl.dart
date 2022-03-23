import 'dart:convert';
import 'dart:io' show Platform;

import 'package:expanse_manager/app/helpers.dart/Globals.dart';
import 'package:expanse_manager/app/models/TransactionResponse.dart';
import 'package:expanse_manager/app/services/NotificationService.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const String channel_id = "123";

class NotificationServiceImpl extends NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void init(
      Future<dynamic> Function(int, String?, String?, String?)? onDidReceive) {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceive);

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: null);

    initializeLocalNotificationsPlugin(initializationSettings);

    tz.initializeTimeZones();
  }

  void initializeLocalNotificationsPlugin(
      InitializationSettings initializationSettings) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
    handleApplicationWasLaunchedFromNotification("");
  }

  Future selectNotification(String? payload) async {
    Transaction transaction = getTransactionFromPayload(payload ?? '');
    cancelNotificationForTransaction(transaction);
    scheduleNotificationForTransaction(
        transaction, "${transaction.description}");
  }

  void showNotification(
      Transaction userBirthday, String notificationMessage) async {
    await flutterLocalNotificationsPlugin.show(
        userBirthday.hashCode,
        applicationName,
        notificationMessage,
        const NotificationDetails(
            android: AndroidNotificationDetails(
                channel_id, 'To remind you about upcoming birthdays')),
        payload: jsonEncode(userBirthday));
  }

  void scheduleNotificationForTransaction(
      Transaction transaction, String notificationMessage) async {
    DateTime now = DateTime.now();
    DateTime birthdayDate = transaction.entryDate!;
    Duration difference = now.isAfter(birthdayDate)
        ? now.difference(birthdayDate)
        : birthdayDate.difference(now);

    _wasApplicationLaunchedFromNotification()
        .then((bool didApplicationLaunchFromNotification) => {
              if (didApplicationLaunchFromNotification &&
                  difference.inDays == 0)
                {}
              else if (!didApplicationLaunchFromNotification &&
                  difference.inDays == 0)
                {showNotification(transaction, notificationMessage)}
            });

    await flutterLocalNotificationsPlugin.zonedSchedule(
        transaction.hashCode,
        applicationName,
        notificationMessage,
        tz.TZDateTime.now(tz.local).add(difference),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                channel_id, 'To remind you about upcoming birthdays')),
        payload: jsonEncode(transaction),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  void cancelNotificationForTransaction(Transaction birthday) async {
    await flutterLocalNotificationsPlugin.cancel(birthday.hashCode);
  }

  void cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  void handleApplicationWasLaunchedFromNotification(String payload) async {
    if (Platform.isIOS) {
      _rescheduleNotificationFromPayload(payload);
      return;
    }

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.didNotificationLaunchApp) {
      _rescheduleNotificationFromPayload(
          notificationAppLaunchDetails.payload ?? "");
    }
  }

  Transaction getUserTransactionFromPayload(String payload) {
    Map<String, dynamic> json = jsonDecode(payload);
    Transaction transaction = Transaction.fromJson(json);
    return transaction;
  }

  Future<bool> _wasApplicationLaunchedFromNotification() async {
    NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails != null) {
      return notificationAppLaunchDetails.didNotificationLaunchApp;
    }

    return false;
  }

  void _rescheduleNotificationFromPayload(String payload) {
    Transaction transaction = getTransactionFromPayload(payload);
    cancelNotificationForTransaction(transaction);
    scheduleNotificationForTransaction(
        transaction, "${transaction.description}");
  }

  @override
  Transaction getTransactionFromPayload(String payload) {
    throw UnimplementedError();
  }
}

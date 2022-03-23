import 'package:expanse_manager/app/models/TransactionResponse.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationService {
  void init(
      Future<dynamic> Function(int, String?, String?, String?)? onDidReceive);
  Future selectNotification(String? payload);
  void showNotification(Transaction transaction, String notificationMessage);
  void scheduleNotificationForTransaction(
      Transaction transaction, String notificationMessage);
  void cancelNotificationForTransaction(Transaction transaction);
  void cancelAllNotifications();
  void handleApplicationWasLaunchedFromNotification(String payload);
  Transaction getTransactionFromPayload(String payload);
}

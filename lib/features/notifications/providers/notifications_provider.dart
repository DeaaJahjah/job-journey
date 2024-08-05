import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:job_journey/core/config/enums/enums.dart';
import 'package:job_journey/core/config/extensions/firebase.dart';
import 'package:job_journey/features/notifications/data/notification.dart';

class NotificationsProvider with ChangeNotifier {
  List<NotificationModel> notifications = [];
  DataState dataState = DataState.notSet;

  void listenToNotifications({required BuildContext context, required String userId}) {
    FirebaseFirestore.instance
        .collection("/'${context.isCompanyAccount ? 'companies' : 'JobSeekers'}'/$userId/notifications")
        .orderBy('created_at')
        .snapshots()
        .listen(
            onError: (e) {
              dataState = DataState.failure;
              notifyListeners();
            },
            onDone: () {},
            (event) {
              final notifications = event.docs.map((snapshot) => NotificationModel.fromFirestore(snapshot)).toList();
              this.notifications = notifications;
              dataState = DataState.done;
              notifyListeners();
            });
  }
}

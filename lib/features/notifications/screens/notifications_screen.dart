import 'package:flutter/material.dart';
import 'package:job_journey/core/config/constant/constant.dart';
import 'package:job_journey/core/config/extensions/loc.dart';
import 'package:job_journey/features/notifications/data/notification.dart';
import 'package:provider/provider.dart';

class NotificationsScreen extends StatelessWidget {
  static const routeName = '/notification-screen';
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const notification = NotificationModel(
        id: '1',
        title: "اسم الشركة",
        body: "وصف عن الوظيفة المقدمة",
        imageUrl: "https://www.shutterstock.com/image-vector/circle-line-simple-design-logo-600nw-2174926871.jpg");
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        toolbarHeight: 90,
        elevation: 0,
        title: Text(context.loc.notifications),
      ),
      body: Consumer(
        builder: (context, proivder, child) {
          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(height: 15),
            itemBuilder: (context, index) => Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: brown, borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(notification.imageUrl),
                  radius: 22,
                ),
                title: Text(
                  notification.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: white),
                ),
                subtitle: Text(
                  notification.body,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

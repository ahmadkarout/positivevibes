import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:core';
import 'package:timezone/timezone.dart' as tz;
import 'dart:async';
import 'package:timezone/data/latest.dart' as tz;

int randomIndex = Random().nextInt(gratitudeSentences.length);
String gratitudeSentences = gratitudeSentences[randomIndex];
String breathingSentences = breathingSentences[randomIndex];
String positiveAffirmationsSentences = positiveAffirmationsSentences[randomIndex];
String selfCareSentences = selfCareSentences[randomIndex];
String mindfulnessSentences = mindfulnessSentences[randomIndex];
String relationshipsSentences = relationshipsSentences[randomIndex];
String positivitySentences = positivitySentences[randomIndex];
String creativitySentences = creativitySentences[randomIndex];
String womenVibesSentences = womenVibesSentences[randomIndex];
String menVibesSentences = menVibesSentences[randomIndex];

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class HelloDialog extends StatelessWidget {
  final String title;

  const HelloDialog({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      actions: [
        TextButton(
          onPressed: () async {
            var androidDetails = AndroidNotificationDetails(
              'channelName',
              'channelDescription',
            );
            //var iOSDetails = IOSNotificationDetails();
            var platformDetails = NotificationDetails(
                android: androidDetails);//, iOS: iOSDetails);


            final DateTime now = DateTime.now();

            final NotificationService notificationService =
            NotificationService();

            for (int year = 0; year < 1; year++) { // Loop for 1 year
              for (int month = now.month; month <= 12; month++) { // Loop for each month of the year
                final DateTime lastDayOfMonth = DateTime(now.year, month + 1, 0);
                for (int day = now.day; day <= lastDayOfMonth.day; day++) { // Loop for each day of the month
                  // Schedule the first notification at 9 AM
                  await notificationService.scheduleNotification(
                    id: 0,
                    title: 'PositiveVibes',
                    body: gratitudeSentences,
                    scheduledTime: DateTime(now.year, now.month, now.day, 20,30),
                  );

                  // Schedule the second notification at 1 PM
                  await notificationService.scheduleNotification(
                    id: 1,
                    title: 'PositiveVibes',
                    body: gratitudeSentences,
                    scheduledTime: DateTime(now.year, now.month, now.day, 20,31),
                  );

                  // Schedule the third notification at 7 PM
                  await notificationService.scheduleNotification(
                    id: 2,
                    title: 'PositiveVibes',
                    body: gratitudeSentences,
                    scheduledTime: DateTime(now.year, now.month, now.day, 20,32),
                  );
                }
              }
            }
            // Close the dialog
            Navigator.pop(context, true);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('We will start pushing you dear'),
            ));
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, false);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Ok! let`s Choose another field'),
            ));
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationService() {
    _configureLocalTimeZone();
  }

  void _configureLocalTimeZone() {
    tz.initializeTimeZones();
    final String timeZoneName = tz.local.name;
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    final AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );

    final NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledTime, tz.local),
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
}
import 'package:corona_tracker/views/navigation2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:corona_tracker/main.dart';
class Notif {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  new FlutterLocalNotificationsPlugin();

  void onTapMalade(BuildContext context) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'result test', 'you should do corona test', platformChannelSpecifics,
        payload: 'item x');

  }

  Future<void> initNotifications(BuildContext context) async {
    var initializationSettingsAndroid = new AndroidInitializationSettings('logo');
    print(initializationSettingsAndroid);
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (i, string1, string2, string3) {
          print("received notifications");
        });
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        // ignore: missing_return

        onSelectNotification: (String string) {
          MyHomePage.currentIndex=2;
         return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
              ModalRoute.withName("home")
          );
        });
  }
}
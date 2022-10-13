import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:timezone/timezone.dart' as tz;

class FCMProvider with ChangeNotifier {
  String? myToken;

  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initInfo() async {
    AndroidInitializationSettings androidSettings =
        const AndroidInitializationSettings("@mipmap/launcher_icon");

    DarwinInitializationSettings iosSettings =
        const DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestCriticalPermission: true,
            requestSoundPermission: true);

    InitializationSettings initializationSettings =
        InitializationSettings(android: androidSettings, iOS: iosSettings);

    notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (response) async {
      try {
        if (response.payload != null && response.payload!.isNotEmpty) {}
      } catch (e) {
        rethrow;
      }
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
        message.notification!.body.toString(),
        htmlFormatBigText: true,
        contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
      );
      AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
        'tokopaedi_channel',
        'tokopaedi_channel',
        icon: '@mipmap/launcher_icon',
        importance: Importance.max,
        styleInformation: bigTextStyleInformation,
        priority: Priority.max,
      );
      NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails,
          iOS: const DarwinNotificationDetails());
      await notificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: message.data['title']);
    });
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      myToken = token;
      notifyListeners();
    });
    saveToken(myToken!);
  }

  void saveToken(String token) async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('userToken').doc(userId).set({
      'token': token,
    });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized ||
        settings.authorizationStatus == AuthorizationStatus.provisional) {
      getToken();
    } else {
      return;
    }
  }

  void showNotification({bool isOrder = true}) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'tokopaedi_channel',
      'tokopaedi_channel',
      icon: '@mipmap/launcher_icon',
      importance: Importance.max,
      priority: Priority.max,
    );
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    DateTime scheduleDate = DateTime.now().add(const Duration(seconds: 5));

    await notificationsPlugin.zonedSchedule(
        0,
        isOrder ? "Your order on progress." : "Your order has been received.",
        isOrder
            ? "Please wait, until the order arrives."
            : "Thank you for ordering in our shop.",
        tz.TZDateTime.from(scheduleDate, tz.local),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true,
        payload: "notification-payload");
  }
}

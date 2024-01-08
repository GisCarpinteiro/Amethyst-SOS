import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    //Initialize the needed android settings
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('splash');

    //Add the android initialization to the initializationSettings object
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    //initialize it
    await notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification({required String message, String title = "SOS Amatista"}) async {
    const AndroidNotificationDetails androidNotifDetails = AndroidNotificationDetails(
      'main',
      'main_notification_chanel',
      channelShowBadge: false,
      enableLights: true,
      enableVibration: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotifDetails);

    await notificationsPlugin.show(
      1,
      'Amatista: Hola!',
      'Esta es una notificación de prueba generada desde la app de amatista',
      notificationDetails,
    );
  }
}

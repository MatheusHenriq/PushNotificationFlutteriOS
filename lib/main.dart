import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:push_notificiation_example/src/services/push_notification_service.dart';
import 'package:push_notificiation_example/src/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.requestPushNotificationPermission().then((value) async {
    //await PushNotificationService.registerDevice();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Push Notification',
      theme: CupertinoThemeData(brightness: Brightness.light, primaryColor: Colors.pinkAccent),
      home: HomeView(),
    );
  }
}

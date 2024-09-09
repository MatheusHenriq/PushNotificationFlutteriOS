import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class PushNotificationService {
  static const String _channelName = "PushNotificationChannel";

  static const MethodChannel _channel = MethodChannel(_channelName);

  static Future<void> requestPushNotificationPermission() async {
    try {
      await _channel.invokeMethod("requestNotificationPermissions");
    } on PlatformException catch (e) {
      throw PlatformException(message: e.message, code: e.code);
    }
  }

  static Future<void> registerDevice() async {
    try {
      await _channel.invokeMethod("registerForPushNotifications");
    } on PlatformException catch (e) {
      throw PlatformException(message: e.message, code: e.code);
    }
  }

  static Future<String?> retriveDeviceToken() async {
    try {
      return await _channel.invokeMethod<String>("retrieveDeviceToken");
    } on PlatformException catch (e) {
      throw PlatformException(message: e.message, code: e.code);
    }
  }

  static handlerPushNotificationData({required BuildContext context}) async {
    _channel.setMethodCallHandler((call) async {
      if (call.method == "onPushNotification") {
        final customKey = call.arguments as String;
        showCupertinoDialog<void>(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('You click on Push Notification'),
            content: Text('The text is -> $customKey'),
            actions: <CupertinoDialogAction>[
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      }
    });
  }
}

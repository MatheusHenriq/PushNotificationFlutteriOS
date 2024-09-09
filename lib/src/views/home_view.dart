import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:push_notificiation_example/src/services/push_notification_service.dart';
import 'package:push_notificiation_example/src/views/widgets/cupertino_snackbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    PushNotificationService.handlerPushNotificationData(context: context);

    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('iOS Push notification'),
        backgroundColor: Colors.pinkAccent,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text('Push notifications Natively iOS'),
            ),
            const SizedBox(
              height: 24,
            ),
            CupertinoButton.filled(
              disabledColor: Colors.pinkAccent,
              child: const Text("Retrieve Device Token"),
              onPressed: () async {
                await PushNotificationService.retriveDeviceToken().then((value) async {
                  await Clipboard.setData(ClipboardData(text: value ?? "")).then((value) {
                    showCupertinoSnackBar(context: context, message: "Device token on clipboard");
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

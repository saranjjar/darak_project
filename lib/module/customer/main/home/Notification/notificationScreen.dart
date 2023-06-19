import 'package:darak_project/helpers/image_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../../../../../helpers/colors_helper.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<RemoteNotification?> notifications =
        ModalRoute.of(context)!.settings.arguments as List<RemoteNotification?>;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorHelper.primaryColor,
        title: const Text(
          'Notification',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        leading: IconButton(
            onPressed: () {
              // Get.offAll(() => HomeScreen());
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
              'There is no Notification',
            ))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                if (notifications[index] != null) {
                  // RemoteNotification notification = notifications[index];
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(ImageHelper.imageApp),
                        ),
                        Expanded(
                          child: ListTile(
                            title: Text(
                              '${notifications[index]?.title}',
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: Text('${notifications[index]?.body}'),
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox();
              }),
    );
  }
}

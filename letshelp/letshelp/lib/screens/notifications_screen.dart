import 'package:flutter/material.dart';
import 'package:letshelp/provider/notification_provider.dart';
import 'package:letshelp/widgets/notification_widget.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProv>(
      builder: (context, notiProv, _) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: kTeal400,
          elevation: 3.0,
          title: Text(
            'الاشعارات ',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: notiProv.gettingNotifications == true &&
                notiProv.reOrderNotifications == false
            ? Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  child: Container(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return NotificationWidget(
                            notification: notiProv.notifications[index]);
                      },
                      itemCount: notiProv.notifications.length,
                    ),
                  ),
                ),
              )
            : notiProv.reOrderNotifications &&
                    notiProv.gettingNotifications == false
                ? Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () async {
                              notiProv.gettingNotifications = false;
                              notiProv.reOrderNotifications = false;
                              await notiProv.getAllNotifications();
                            },
                            icon: Icon(
                              Icons.refresh,
                              color: kTeal400,
                              size: 48,
                            )),
                      ],
                    ),
                  )
                : notiProv.reOrderNotifications == false &&
                        notiProv.gettingNotifications == false
                    ? Center(
                        child: CircularProgressIndicator(
                          color: kTeal400,
                        ),
                      )
                    : Center(
                        child: Text("لايوجد اشعارات "),
                      ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:letshelp/models/notification_model.dart';
import 'package:letshelp/provider/notification_provider.dart';
import 'package:letshelp/provider/order-provider.dart';
import 'package:letshelp/provider/product.dart';
import 'package:letshelp/screens/all-orders.dart';
import 'package:letshelp/screens/single-product.dart';
import 'package:letshelp/theme/colors.dart';
import 'package:provider/provider.dart';

class NotificationWidget extends StatelessWidget {
  const NotificationWidget({Key? key, required this.notification})
      : super(key: key);
  final NotificationModel notification;
  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProv>(
      builder: (context, nP, _) => InkWell(
        onTap: () async {
          print(
              "the notification type is : ${notification.type} ${notification.idOnPage}");
          if (notification.type == 5) {
            final prov = await Provider.of<Product>(context, listen: false);

            prov.getProductById(notification.idOnPage!).then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SingleProductScreen(),
                ),
              );
            });
          } else if (notification.type == 6) {
            print("yse: ${notification.idOnPage}");
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AllOrders()));
            await Provider.of<OrderProvider>(context, listen: false)
                .getAllOrders(orderId: notification.idOnPage);
          }
        },
        child: Card(
          color: notification.isRead ? Colors.white : kGrey501,
          elevation: 5,
          shadowColor:
              notification.isRead ? Color.fromARGB(255, 71, 65, 65) : kGrey501,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              title: Text(notification.text),
              leading: Icon(Icons.notifications),
              trailing: notification.isRead ? Text("") : Text("غير مقروء"),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:letshelp/provider/profile-provider.dart';
import 'package:provider/provider.dart';
import '../theme/colors.dart';
import '../widgets/single-order-widget.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kTeal400,
          title: Text(
            " طلباتي",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
      body: FutureBuilder(
          future: Future.wait([profileProvider.getMyOrder()]),
          builder: (context, AsyncSnapshot snapshotData) {
            if (profileProvider.getOrders == false) {
              return Center(
                child: const CircularProgressIndicator(
                  color: kTeal400,
                ),
              );
            } else {
              if (profileProvider.myOrders != 0) {
                return ListView.builder(
                    itemBuilder: (context, index) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: SingleOrderWidget(
                          title: profileProvider.myOrders[index].title,
                          orderID: profileProvider.myOrders[index].orderID,
                          category: profileProvider.myOrders[index].category,
                          address: profileProvider.myOrders[index].address,
                          city: profileProvider.myOrders[index].city,
                          clientImage:
                              profileProvider.myOrders[index].clientImage,
                          clientName:
                              profileProvider.myOrders[index].clientName,
                          country: profileProvider.myOrders[index].clientName,
                          date: profileProvider.myOrders[index].date,
                          description:
                              profileProvider.myOrders[index].description,
                          status: profileProvider.myOrders[index].status,
                          index: index,
                        ),
                      );
                    },
                    itemCount: profileProvider.myOrders.length);
              } else {
                return Center(child: Text("لايوجد لديك اي طلبات "));
              }
            }
          }),
    );
  }
}

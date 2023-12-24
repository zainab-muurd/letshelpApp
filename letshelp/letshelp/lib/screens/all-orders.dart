import 'package:flutter/material.dart';
import 'package:letshelp/provider/order-provider.dart';
import 'package:letshelp/widgets/single-order-widget.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';

class AllOrders extends StatelessWidget {
  const AllOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kTeal400,
          elevation: 3.0,
          title: Text(
            'الطلبات',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: Consumer<OrderProvider>(
          builder: (context, orderProvider, _) => orderProvider.isOrdersGet
              ? orderProvider.allOrder.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: SingleOrderWidget(
                            title: orderProvider.allOrder[index].title,
                            orderID: orderProvider.allOrder[index].orderID,
                            category: orderProvider.allOrder[index].category,
                            address: orderProvider.allOrder[index].address,
                            city: orderProvider.allOrder[index].city,
                            clientImage:
                                orderProvider.allOrder[index].clientImage,
                            clientName:
                                orderProvider.allOrder[index].clientName,
                            country: orderProvider.allOrder[index].clientName,
                            date: orderProvider.allOrder[index].date,
                            description:
                                orderProvider.allOrder[index].description,
                            index: index,
                          ),
                        );
                      },
                      itemCount: orderProvider.allOrder.length)
                  : Center(
                      child: Text("العنصر غير متوفر"),
                    )
              : Center(
                  child: CircularProgressIndicator(
                    color: kTeal400,
                  ),
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:letshelp/provider/profile-provider.dart';
import 'package:letshelp/widgets/requested-item-w.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';

class RequestedItemsScreen extends StatelessWidget {
  const RequestedItemsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) => Scaffold(
        appBar: AppBar(
            backgroundColor: kTeal400,
            title: Text(
              "المنتجات التي طلبت",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
        body: Container(
          child: profileProvider.getMyRequestedItem? ListView.separated(
            controller: profileProvider.scrollController,
              itemBuilder: (contex, index) {
                return RequestedItemW(
               requestedItem: profileProvider.requestedItem[index],
                    index: index,
                    key:  ValueKey(index),

                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height*.03,
                );
              },
              itemCount: profileProvider.requestedItem.length): Center(child: CircularProgressIndicator(
            color: kTeal400,
          ),),
        ),
      ),
    );
  }
}

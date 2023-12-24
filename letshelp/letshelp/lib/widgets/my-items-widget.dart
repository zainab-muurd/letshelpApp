import 'package:flutter/material.dart';
import 'package:letshelp/theme/colors.dart';
import 'package:provider/provider.dart';

import '../provider/profile-provider.dart';

class MyItemsWidget extends StatelessWidget {
  const MyItemsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return FutureBuilder(
        future: Future.wait([profileProvider.getMyItems()]),
        builder: (context, AsyncSnapshot snapshotData) {
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: const CircularProgressIndicator(
                    color: kTeal400,
                  ),
                ),
              ],
            );
          } else {
            if (profileProvider.myItems != 0) {
              return SizedBox(
                height: height,
                width: width,
                child: GridView.builder(
                  physics: ScrollPhysics(),
                  padding: const EdgeInsets.all(6),
                  itemCount: profileProvider.myItems.length,
                  itemBuilder: (ctx, i) {
                    return profileProvider.myItems[i];
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 5 / 7,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10,
                  ),
                ),
              );
            } else {
              return Center(child: Text("لايوجد عناصر"));
            }
          }
        });
  }
}

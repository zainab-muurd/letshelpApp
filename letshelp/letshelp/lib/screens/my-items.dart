import 'package:flutter/material.dart';
import 'package:letshelp/widgets/my-items-widget.dart';

import '../theme/colors.dart';

class MyItems extends StatelessWidget {
  const MyItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: kTeal400,
          title: Text(
            "منتجاتي ",
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
      body: SingleChildScrollView(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                MyItemsWidget(),
              ],
            ),
          );
        }),
      ),
    );
  }
}

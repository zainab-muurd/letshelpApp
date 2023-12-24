import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/availbelproduct.dart';

class Product extends StatefulWidget {
  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kTeal400,
            title: Text(
              "المنتجات",
              style: TextStyle(color: Colors.white, fontSize: 20),
            )),
        body: ListView.builder(
            padding: EdgeInsets.all(0),
            itemBuilder: (context, index) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .8,
                      child: AvailbaleProductWidget(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .1,
                    )
                  ],
                )));
  }
}

import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../widgets/availbelproduct.dart';

class AvailableMaterials extends StatefulWidget {
  const AvailableMaterials({Key? key}) : super(key: key);

  @override
  State<AvailableMaterials> createState() => _AvailableMaterialsState();
}

class _AvailableMaterialsState extends State<AvailableMaterials> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: kTeal400,
            title: Text(
              "المواد المتاحة ",
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
                  AvailbaleProductWidget(),
                ],
              ),
            );
          }),
        ));
  }
}

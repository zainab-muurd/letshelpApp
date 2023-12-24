import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/itemavelbl_provider.dart';
import '../theme/colors.dart';

class AvailbaleProductWidget extends StatefulWidget {
  const AvailbaleProductWidget({Key? key}) : super(key: key);

  @override
  _AvailbaleProductWidgetState createState() => _AvailbaleProductWidgetState();
}

class _AvailbaleProductWidgetState extends State<AvailbaleProductWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final itemProv = Provider.of<ItemAvailableProvider>(context, listen: false);
    return FutureBuilder(
        future: Future.wait([itemProv.getitemsavailable()]),
        builder: (BuildContext ctx, AsyncSnapshot snapshotData) {
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return Center(
              child: const CircularProgressIndicator(
                color: kTeal400,
              ),
            );
          } else {
            if (itemProv.items != 0) {
              return SizedBox(
                height: height,
                width: width,
                child: GridView.builder(
                  physics: ScrollPhysics(),
                  padding: const EdgeInsets.all(6),
                  itemCount: itemProv.items!.length,
                  itemBuilder: (ctx, i) => itemProv.items![i],
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.6 / 3.5,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 10,
                  ),
                ),
              );
            } else {
              return Center(child: Text("لايوجد عناصر في هذة الفئة"));
            }
          }
        });
  }
}

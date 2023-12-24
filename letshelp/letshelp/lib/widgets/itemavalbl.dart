// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:letshelp/provider/product.dart';
import 'package:letshelp/provider/profile-provider.dart';
import 'package:letshelp/screens/single-product.dart';
import 'package:letshelp/theme/colors.dart';
import 'package:provider/provider.dart';

import '../screens/item-requestes.dart';

class ItemAvalbl extends StatelessWidget {
  ItemAvalbl({
    Key? key,
    required this.category,
    required this.id,
    required this.name,
    required this.Icon,
    this.isMyItems = false,
  }) : super(key: key);
  final int? id;
  final String? name;
  final String? Icon;
  final String? category;
  bool? isMyItems;

  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(
      builder: (context, productProvider, _) => InkWell(
        onTap: () async {
          if (isMyItems == true) {
            return;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SingleProductScreen(),
            ),
          );
          await productProvider.getProductById(id!);
        },
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              side: BorderSide(color: kTeal400, width: 2)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                width: double.infinity,
                child: Image.network(
                  '$Icon',
                  fit: BoxFit.contain,
                ),
              ),
              Container(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "$category",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("$name"),
                      Text("تاريخ النشر : 11/11/2022"),
                      isMyItems!
                          ? Consumer<ProfileProvider>(
                              builder: (context, profileProvider, _) =>
                                  TextButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all(kTeal400)),
                                onPressed: () async {
                                  profileProvider.requestsFilter = true;
                                  await profileProvider
                                      .getMyProductsRequests(id!);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ItemRequestes(
                                                title: name,
                                              )));
                                },
                                child: Center(
                                    child: Text(
                                  "عرض الطلبات",
                                  style: TextStyle(color: kTeal400),
                                )),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

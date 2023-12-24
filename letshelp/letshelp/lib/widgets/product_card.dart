import 'package:flutter/material.dart';
import 'package:letshelp/models/show_items_mpdels.dart';
import 'package:letshelp/provider/show_items_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/image.dart' as iii;

import '../theme/colors.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({Key? key}) : super(key: key);

  @override
  _ProductCardWidgetState createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final showitemmod = Provider.of<ShowItemModel>(context, listen: false);
    final showitemProv = Provider.of<ShowItemsProvider>(context, listen: false);
    return FutureBuilder(
        future: Future.wait([showitemProv.getshowitems()]),
        builder: (ctx, AsyncSnapshot snapshotData) {
          if (snapshotData.connectionState == ConnectionState.waiting) {
            return const Center(
              child: const CircularProgressIndicator(),
            );
          } else {
            return Container(
              height: height * .99,
              width: width * .99,
              child: GridView.builder(
                padding: const EdgeInsets.all(6),
                itemCount: showitemProv.Showitems.length,
                itemBuilder: (ctx, i) => Provider.value(
                  value: showitemProv.Showitems[i],
                  child: Container(
                    height: height * 0.35,
                    width: width * 0.45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        // border: Border.all(width: 4,color: kTeal100),
                        color: kLightPrimary,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, 3),
                            blurRadius: 10,
                          )
                        ]),
                    child: Stack(
                      children: [
                        GestureDetector(
                            onTap: () {},
                            child: Stack(children: [
                              Container(
                                width: MediaQuery.of(context).size.width * .45,
                                height:
                                    MediaQuery.of(context).size.height * .35,

                                /// 150.0
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    boxShadow: [
                                      BoxShadow(
                                        offset: Offset(0, 3),
                                        blurRadius: 6,
                                        color: kTeal400,
                                      )
                                    ]),
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .35,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .25,
                                            child: iii.Image.network(
                                              showitemmod.mainImage!,
                                              fit: BoxFit.fill,
                                              color: kTeal400,
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.all(0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    showitemmod.title!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            color: kTeal400,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                  ),
                                                  SizedBox(
                                                    width: width * .02,
                                                  ),
                                                  Text(showitemmod.cateagory!,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 15)),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'تاريخ النشر:2-2-2022',
                                                    textAlign: TextAlign.left,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                          color: kGrey500,
                                                          fontSize: 10,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Positioned(
                                    //   bottom: 0,
                                    //   right: 0,
                                    //   child: GestureDetector(
                                    //     onTap: () {
                                    //       ScaffoldMessenger.of(context)
                                    //           .hideCurrentSnackBar();
                                    //       ScaffoldMessenger.of(context)
                                    //           .showSnackBar(SnackBar(
                                    //               content: Text(
                                    //                 "تم الطلب",
                                    //                 style: Theme.of(context)
                                    //                     .textTheme
                                    //                     .bodyText1!
                                    //                     .copyWith(
                                    //                         fontSize: 14,
                                    //                         color: kTeal400),
                                    //               ),
                                    //               action: SnackBarAction(
                                    //                   label: "الغاء",
                                    //                   textColor: Colors.white,
                                    //                   onPressed: () {})));
                                    //     },
                                    //     child: Container(
                                    //       height: height / 16.66,
                                    //
                                    //       /// 50.0
                                    //       width: width / 9.22,
                                    //
                                    //       /// 50.0
                                    //       decoration: BoxDecoration(
                                    //           color: kTeal400,
                                    //           borderRadius: const BorderRadius.only(
                                    //             bottomRight: Radius.circular(20.0),
                                    //             topLeft: Radius.circular(20.0),
                                    //           )),
                                    //       child: const Icon(
                                    //         Icons.add,
                                    //         color: Colors.white,
                                    //       ),
                                    //     ),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ])),
                      ],
                    ),
                  ),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 3 / 3.5,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 10,
                ),
              ),
            );
          }
        });
  }
}

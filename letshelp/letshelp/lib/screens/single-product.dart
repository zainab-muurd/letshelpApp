import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../provider/product.dart';
import '../theme/colors.dart';
import '../widgets/ProfileAvatar.dart';

class SingleProductScreen extends StatelessWidget {
  const SingleProductScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int current = 0;
    final Size size = MediaQuery.of(context).size;

    return Consumer<Product>(
      builder: (context, productProvider, _) => Scaffold(
          appBar: AppBar(
            backgroundColor: kTeal400,
            elevation: 3.0,
            title: Text(
              productProvider.singleProduct == null
                  ? "فالنتساعد"
                  : productProvider.singleProduct!.title,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          body: productProvider.singleProduct == null
              ? Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            productProvider.singleProduct!.images!.length ==
                                        0 ||
                                    productProvider
                                            .singleProduct!.images!.length ==
                                        1
                                ? Image.network(
                                    productProvider.singleProduct!.mainImage)
                                : Container(
                                    //padding: EdgeInsets.symmetric(vertical: 30),

                                    height: size.height * 0.55,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: CarouselSlider(
                                            carouselController:
                                                productProvider.controller,
                                            options: CarouselOptions(
                                                aspectRatio: 5.5 / 7,
                                                viewportFraction: 1,
                                                enableInfiniteScroll: true,
                                                reverse: false,
                                                enlargeCenterPage: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                onPageChanged: (index, reason) {
                                                  productProvider
                                                      .indicatorChanger(
                                                          index, reason);
                                                  current =
                                                      productProvider.current;
                                                }),
                                            items: productProvider
                                                .singleProduct!.images!
                                                .map((i) {
                                              return Builder(
                                                builder:
                                                    (BuildContext context) {
                                                  return Image.network(
                                                    i,
                                                    fit: BoxFit.fill,
                                                  );
                                                },
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: productProvider
                                              .singleProduct!.images!
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            return GestureDetector(
                                              onTap: () => productProvider
                                                  .controller
                                                  .animateToPage(entry.key),
                                              child: Container(
                                                width: 12.0,
                                                height: 12.0,
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                    horizontal: 4.0),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: (Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? Colors.white
                                                            : kTeal400)
                                                        .withOpacity(
                                                            current == entry.key
                                                                ? 1
                                                                : 0.3)),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                        Divider(
                                          thickness: 2,
                                        )
                                      ],
                                    ),
                                  ),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10, left: 0, right: 10, bottom: 10),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: size.height * 0.02),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 2,
                                                                horizontal: 20),
                                                        color: kTeal400,
                                                        child: Text(
                                                          "الناشر",
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  alignment: Alignment.center,
                                                  child: ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                kTeal400),
                                                    onPressed: () async {
                                                      AwesomeDialog(
                                                          context: context,
                                                          title:
                                                              "إضافة طلب جديد",
                                                          body: Form(
                                                            key: productProvider
                                                                .reasonForm,
                                                            child:
                                                                Directionality(
                                                              textDirection:
                                                                  TextDirection
                                                                      .rtl,
                                                              child: Container(
                                                                child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Text(
                                                                          "ادخل سبب الطلب ",
                                                                        ),
                                                                        Text(
                                                                          "(مطلوب)",
                                                                          style: TextStyle(
                                                                              color: kTeal400,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          25,
                                                                    ),
                                                                    Directionality(
                                                                      textDirection:
                                                                          TextDirection
                                                                              .rtl,
                                                                      child: TextFormField(
                                                                          validator: (value) {
                                                                            value =
                                                                                productProvider.reason.text;
                                                                            if (value.isEmpty) {
                                                                              return "هذا الحقل مطلوب  ";
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                          controller: productProvider.reason,
                                                                          maxLines: null,
                                                                          decoration: InputDecoration(
                                                                            labelText:
                                                                                " سبب الطلب ... ",
                                                                            labelStyle:
                                                                                TextStyle(fontSize: 12, color: Colors.black),
                                                                            fillColor:
                                                                                Colors.white,
                                                                            focusedBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: BorderSide(
                                                                                color: kTeal400,
                                                                                width: 2.0,
                                                                              ),
                                                                            ),
                                                                            enabledBorder:
                                                                                OutlineInputBorder(
                                                                              borderRadius: BorderRadius.circular(10),
                                                                              borderSide: BorderSide(
                                                                                color: kTeal400,
                                                                                width: 2.0,
                                                                              ),
                                                                            ),
                                                                          )),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          25,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          btnOkText:
                                                              "اطلب الأن",
                                                          btnCancelText:
                                                              "الغاء الطلب",
                                                          btnCancelOnPress: () {
                                                            print(
                                                                "الغاء الطلب");
                                                          },
                                                          btnOkColor: kTeal400,
                                                          btnCancelColor:
                                                              kGrey500,
                                                          btnOkOnPress:
                                                              () async {
                                                            if (productProvider
                                                                .reasonForm
                                                                .currentState!
                                                                .validate()) {
                                                              await productProvider
                                                                  .requestForProduct(
                                                                      productProvider
                                                                          .singleProduct!
                                                                          .id);
                                                              if (productProvider
                                                                  .isProductRequest) {
                                                                AwesomeDialog(
                                                                  context:
                                                                      context,
                                                                  animType: AnimType
                                                                      .TOPSLIDE,
                                                                  dialogType:
                                                                      DialogType
                                                                          .SUCCES,
                                                                  title:
                                                                      "تم الطلب",
                                                                  body:
                                                                      Container(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "تم ارسال الطلب بنجاح",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              kTeal400,
                                                                          fontSize:
                                                                              22,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  btnOkColor:
                                                                      kTeal400,
                                                                  btnOkOnPress:
                                                                      () {},
                                                                ).show();
                                                              } else if (productProvider
                                                                          .isProductRequest ==
                                                                      false &&
                                                                  productProvider
                                                                      .failedMessage!
                                                                      .isNotEmpty) {
                                                                AwesomeDialog(
                                                                  context:
                                                                      context,
                                                                  animType: AnimType
                                                                      .TOPSLIDE,
                                                                  dialogType:
                                                                      DialogType
                                                                          .ERROR,
                                                                  title:
                                                                      "تم الطلب",
                                                                  body:
                                                                      Container(
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        "${productProvider.failedMessage!}",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              kTeal400,
                                                                          fontSize:
                                                                              22,
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  btnOkColor:
                                                                      kTeal400,
                                                                  btnOkOnPress:
                                                                      () {},
                                                                ).show();
                                                              }
                                                            } else {
                                                              print(
                                                                  "لم يتم الطلب");
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .hideCurrentSnackBar();
                                                              ScaffoldMessenger.of(context).showSnackBar(
                                                                  SnackBar(
                                                                      content:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                            "لم يتم الطلب الرجاء إدخال السبب ",
                                                                            style:
                                                                                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 14, color: kTeal400),
                                                                          ),
                                                                          Icon(
                                                                            Icons.info_outline_rounded,
                                                                            color:
                                                                                Colors.red,
                                                                          )
                                                                        ],
                                                                      ),
                                                                      action: SnackBarAction(
                                                                          label:
                                                                              "الغاء",
                                                                          textColor: Colors
                                                                              .white,
                                                                          onPressed:
                                                                              () {})));
                                                            }
                                                          },
                                                          customHeader:
                                                              ClipOval(
                                                            child:
                                                                Image.network(
                                                              "${productProvider.singleProduct!.mainImage}",
                                                              width: 100,
                                                              height: 100,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          )).show();
                                                    },
                                                    child: Text("طلب المنتج",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 23,
                                                          //fontFamily: 'TrajanPro' )
                                                        )),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 10),
                                                child: Column(
                                                  children: [
                                                    ProfileAvatar(
                                                      singleProduct:
                                                          productProvider
                                                              .singleProduct!,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                        "${productProvider.singleProduct!.clientName}")
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            // Container(
                                            //   width: double.infinity,
                                            //   child: Column(
                                            //     crossAxisAlignment:
                                            //         CrossAxisAlignment.start,
                                            //     children: [
                                            //       Container(
                                            //         padding: EdgeInsets.symmetric(
                                            //             vertical: 2,
                                            //             horizontal: 20),
                                            //         color: kTeal400,
                                            //         child: Text(
                                            //           "المواصفات",
                                            //           style: TextStyle(
                                            //               fontSize: 20,
                                            //               fontWeight:
                                            //                   FontWeight.bold,
                                            //               color: Colors.white),
                                            //         ),
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                            // SizedBox(
                                            //   height: size.height * 0.01,
                                            // ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 0,
                                                  child: Text(
                                                    "المنتج :",
                                                    style: TextStyle(
                                                        color: kTeal400,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "${productProvider.singleProduct!.title}",
                                                    maxLines: null,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * 0.01,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  flex: 0,
                                                  child: Text(
                                                    "الوصف :",
                                                    style: TextStyle(
                                                        color: kTeal400,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    "${productProvider.singleProduct!.description}",
                                                    maxLines: null,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: size.height * 0.02,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
    );
  }
}

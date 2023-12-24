// ignore_for_file: must_be_immutable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:letshelp/provider/profile-provider.dart';
import 'package:provider/provider.dart';

import '../provider/order-provider.dart';
import '../theme/colors.dart';

class SingleOrderWidget extends StatelessWidget {
  SingleOrderWidget(
      {Key? key,
      required this.orderID,
      required this.title,
      required this.description,
      required this.country,
      required this.city,
      required this.address,
      required this.clientName,
      required this.clientImage,
      required this.category,
      required this.date,
      required this.index,
      this.status})
      : super(key: key);

  final int orderID;
  final String title;
  final String description;
  final String country;
  final String city;
  final String address;
  final String clientName;
  final String clientImage;
  final String category;
  final String date;
  final int index;
  final int? status;

  String? shortDescription;

  @override
  Widget build(BuildContext context) {
    if (this.description.length > 23) {
      shortDescription = this.description.substring(0, 22);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          decoration: BoxDecoration(
              color: index % 2 != 0 ? kTeal400 : Color(0xFF7e8f94),
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 5,
                  color: index % 2 != 0 ? kTeal400 : Color(0xFF7e8f94),
                )
              ]),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        ClipOval(
                          child: Image.network(
                            this.clientImage,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          this.clientName,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            this.category,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(this.title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold)),
                          Text(
                            this.description.length > 23
                                ? "${shortDescription!} ..."
                                : this.description,
                            style: TextStyle(color: Colors.white),
                          ),
                          this.description.length > 23
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: this.index % 2 == 0
                                              ? kTeal400
                                              : kGrey400),
                                      onPressed: () {
                                        AwesomeDialog(
                                            context: context,
                                            dialogBackgroundColor: kTeal400,
                                            borderSide: BorderSide(width: 0),
                                            padding: EdgeInsets.all(0),
                                            barrierColor:
                                                Colors.black.withOpacity(0.7),
                                            customHeader: ClipOval(
                                              child: Image.network(
                                                this.clientImage,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            body: Container(
                                              color: Colors.white,
                                              child: Directionality(
                                                textDirection:
                                                    TextDirection.rtl,
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          color: kTeal400,
                                                          boxShadow: [
                                                            BoxShadow(
                                                              offset:
                                                                  Offset(0, 4),
                                                              blurRadius: 5,
                                                              color: Color(
                                                                  0xFF7e8f94),
                                                            )
                                                          ]),
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 3,
                                                              horizontal: 8),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          ClipOval(
                                                            child:
                                                                Image.network(
                                                              this.clientImage,
                                                              width: 50,
                                                              height: 50,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          Text(
                                                            this.clientName,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.03,
                                                      color: Colors.white,
                                                    ),
                                                    Container(
                                                      color: Colors.white,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                              this.description),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )).show();
                                      },
                                      child: Text("متابعة القراءة")),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Consumer<OrderProvider>(
                            builder: (context, orderProvider, _) => this
                                        .status ==
                                    null
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: this.index % 2 == 0
                                            ? kTeal400
                                            : kGrey400),
                                    onPressed: () {
                                      AwesomeDialog(
                                          context: context,
                                          title: "إضافة طلب جديد",
                                          body: Form(
                                            key: orderProvider.messageForm,
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Container(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          "ارسال رسالة ",
                                                        ),
                                                        Text(
                                                          "(مطلوب)",
                                                          style: TextStyle(
                                                              color: kTeal400,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                    Directionality(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      child: TextFormField(
                                                          validator: (value) {
                                                            value = orderProvider
                                                                .messageForOrderResponse
                                                                .text;
                                                            if (value.isEmpty) {
                                                              return "هذا الحقل مطلوب  ";
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                          controller: orderProvider
                                                              .messageForOrderResponse,
                                                          maxLines: null,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                " اترك رسالة لصاحب الطلب ... ",
                                                            labelStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black),
                                                            fillColor:
                                                                Colors.white,
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: kTeal400,
                                                                width: 2.0,
                                                              ),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              borderSide:
                                                                  BorderSide(
                                                                color: kTeal400,
                                                                width: 2.0,
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                    SizedBox(
                                                      height: 25,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          btnOkText: "تأكيد",
                                          btnCancelText: "الغاء",
                                          btnCancelOnPress: () {
                                            print("الغاء ");
                                          },
                                          btnOkColor: kTeal400,
                                          btnCancelColor: kGrey500,
                                          btnOkOnPress: () async {
                                            if (orderProvider
                                                .messageForm.currentState!
                                                .validate()) {
                                              orderProvider.responseOrder ==
                                                      false
                                                  ? CircularProgressIndicator()
                                                  : AwesomeDialog(
                                                      context: context,
                                                      animType:
                                                          AnimType.TOPSLIDE,
                                                      dialogType: orderProvider
                                                                  .orderResponseCode ==
                                                              422
                                                          ? DialogType.ERROR
                                                          : DialogType.SUCCES,
                                                      title: orderProvider
                                                                  .orderResponseCode ==
                                                              422
                                                          ? "فشل العملية"
                                                          : "تمت العملية",
                                                      body: Directionality(
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(8),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            orderProvider
                                                                        .orderResponseCode ==
                                                                    422
                                                                ? "${orderProvider.filedMessage}"
                                                                : "تم العملية بنجاح سوف تظهر رسالتك في الصندوق الوارد",
                                                            style: TextStyle(
                                                              color: orderProvider
                                                                          .orderResponseCode ==
                                                                      422
                                                                  ? Colors.grey
                                                                  : kTeal400,
                                                              fontSize: 22,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      btnOkColor: orderProvider
                                                                  .orderResponseCode ==
                                                              422
                                                          ? Colors.red
                                                          : kTeal400,
                                                      btnOkOnPress: () {},
                                                    ).show();
                                              await orderProvider
                                                  .orderResponse(this.orderID);
                                            } else {
                                              print("لم يتم الطلب");
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                      content: Row(
                                                        children: [
                                                          Text(
                                                            "لم يتم الطلب الرجاء ترك رسالة ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText1!
                                                                .copyWith(
                                                                    fontSize:
                                                                        14,
                                                                    color:
                                                                        kTeal400),
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .info_outline_rounded,
                                                            color: Colors.red,
                                                          )
                                                        ],
                                                      ),
                                                      action: SnackBarAction(
                                                          label: "الغاء",
                                                          textColor:
                                                              Colors.white,
                                                          onPressed: () {})));
                                            }
                                          },
                                          customHeader: ClipOval(
                                            child: Image.network(
                                              "${this.clientImage}",
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.contain,
                                            ),
                                          )).show();
                                    },
                                    child: Text("اجابة"))
                                : Container(
                                    child: Consumer<ProfileProvider>(
                                      builder: (context, profileProvider, _) =>
                                          ElevatedButton(
                                        onPressed: () {
                                          if (this.status == 3) {
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.QUESTION,
                                              btnOkOnPress: () async {
                                                await profileProvider
                                                    .orderStatusUpdate(
                                                        this.orderID);
                                                if (profileProvider
                                                    .updateStateMessage!
                                                    .isNotEmpty) {
                                                  AwesomeDialog(
                                                      context: context,
                                                      dialogType:
                                                          DialogType.SUCCES,
                                                      body: Center(
                                                        child: Container(
                                                          child: Text(
                                                              "${profileProvider.updateStateMessage}"),
                                                        ),
                                                      )).show();
                                                }
                                              },
                                              btnCancelOnPress: () {},
                                              btnOkText: "استلمت طلبي",
                                              btnCancelText: "لم استلم طلبي",
                                              btnCancelColor: Colors.grey,
                                            ).show();
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: this.status == 1
                                              ? Color(0xff68c2d0)
                                              : this.status == 2
                                                  ? kTeal400
                                                  : this.status == 3
                                                      ? Color(0xff68c2d0)
                                                      : kTeal400,
                                        ),
                                        child: Column(
                                          children: [
                                            this.status == 3
                                                ? Icon(Icons.ads_click)
                                                : Container(),
                                            Text(
                                              this.status == 1
                                                  ? "قيد الانتظار"
                                                  : this.status == 2
                                                      ? "مقبول"
                                                      : this.status == 3
                                                          ? "قيد الإنهاء"
                                                          : "منهي",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: this.status == 1 ||
                                                          this.status == 3
                                                      ? 12
                                                      : 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )),
                      ))
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "${this.city}-",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(this.country, style: TextStyle(color: Colors.white)),
                      Text("-${this.address}",
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                  Text(this.date, style: TextStyle(color: Colors.white))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

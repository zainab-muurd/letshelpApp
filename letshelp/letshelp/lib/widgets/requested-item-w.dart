// ignore_for_file: must_be_immutable

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:letshelp/models/requestd-item.dart';
import 'package:letshelp/provider/profile-provider.dart';
import 'package:letshelp/theme/colors.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RequestedItemW extends StatelessWidget {
  RequestedItemW({
    Key? key,
    required this.requestedItem,
    required this.index,
    this.ratingW,
  }) : super(key: key);

  RequestedItem requestedItem;
  final int index;
  double? ratingW = 1;

  @override
  Widget build(BuildContext context) {
    print(
        "the status is ${requestedItem.requestStatus} ${requestedItem.requestId}");
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Consumer<ProfileProvider>(
        builder: (context, profileProvider, _) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
          child: Container(
            decoration: BoxDecoration(
                color: index % 2 == 0 ? kGrey500 : kTeal400,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 1,
                    color: index % 2 != 0 ? kTeal400 : Color(0xFF7e8f94),
                  )
                ]),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ClipOval(
                      child: Image.network(
                        "${requestedItem.requestItemImage}",
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Column(
                      children: [
                        Text("${requestedItem.requestText}",
                            style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        Text("${requestedItem.requestItemName}",
                            style: TextStyle(color: Colors.white))
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .04,
                        ),
                        ClipOval(
                          child: Image.network(
                            "${requestedItem.requestClientImage}",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Text(
                          "${requestedItem.requestItemClientName}",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                        Text(
                          "${requestedItem.requestClientPhone}",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .01,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: {requestedItem.requestStatus} == 1
                      ? [
                          Text(
                            " للأسف تم رفض طلبك ",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                        ]
                      : {requestedItem.requestStatus} == 2
                          ? [
                              Text("تم قبول طلبك ",
                                  style: TextStyle(color: Colors.greenAccent)),
                            ]
                          : {requestedItem.requestStatus} == 3
                              ? [
                                  ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  index % 2 != 0
                                                      ? kGrey500
                                                      : kTeal400)),
                                      onPressed: () {
                                        AwesomeDialog(
                                            context: context,
                                            dismissOnTouchOutside: false,
                                            btnOk: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors
                                                                .greenAccent)),
                                                onPressed: () async {
                                                  profileProvider
                                                      .finishRequestedItem(
                                                          this
                                                              .requestedItem
                                                              .requestItemClientId,
                                                          this
                                                              .requestedItem
                                                              .requestId,
                                                          ratingW!)
                                                      .then((statusCode) {
                                                    if (statusCode == 200) {
                                                      Navigator.pop(context);
                                                      AwesomeDialog(
                                                              context: context,
                                                              dialogType:
                                                                  DialogType.SUCCES,
                                                              body: Container(
                                                                child: Center(
                                                                  child: Text(
                                                                      "تمت اعملية بنجاح"),
                                                                ),
                                                              ))
                                                          .show()
                                                          .then((value) async {
                                                        await profileProvider
                                                            .myRequestedItem();
                                                      });
                                                    } else {
                                                      AwesomeDialog(
                                                          context: context,
                                                          dialogType:
                                                              DialogType.ERROR,
                                                          body: Container(
                                                            child: Center(
                                                              child: Text(
                                                                  "هنالك خطأ ما "),
                                                            ),
                                                          )).show();
                                                    }
                                                  });
                                                },
                                                child: Text("إنهاء الطلب")),
                                            btnCancel: ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(Colors
                                                                .redAccent)),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text("الغاء")),

                                            // dialogType: DialogType.NO_HEADER,
                                            customHeader: ClipOval(
                                              child: (Icon(Icons.star,
                                                  size: 100,
                                                  color: Colors.amber)),
                                            ),
                                            body: Container(
                                              child: Center(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                        "الرجاء التقيم لإنهاء الطلب"),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .01,
                                                    ),
                                                    RatingBar.builder(
                                                      initialRating: 1,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      //allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 4.0),
                                                      itemBuilder:
                                                          (context, _) => Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                      ),
                                                      onRatingUpdate: (rating) {
                                                        ratingW = rating;
                                                        print(ratingW);
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              .01,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )).show();
                                      },
                                      child: Text(
                                          "منهي / قم بالتقيم لتأكيد الاستلام")),
                                ]
                              : [Text("منهى من قبل مقدم الطلب")],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

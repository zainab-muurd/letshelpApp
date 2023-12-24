import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:letshelp/provider/profile-provider.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';

class ItemRequestW extends StatelessWidget {
  ItemRequestW(
      {Key? key,
      required this.mdh,
      required this.mdw,
      required this.index,
      required this.requestId,
      required this.requestText,
      required this.requestClient,
      required this.requestStatus,
      required this.requestClientImage,
      required this.requestClientPhone})
      : super(key: key);
  final mdw;
  final mdh;
  final int index;
  final int requestId;
  final String requestText;
  final String requestClient;
  final String requestClientPhone;
  final String requestClientImage;
  final int requestStatus;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(
      builder: (context, profileProvider, _) => Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: Center(
                child: Container(
                  child: LayoutBuilder(
                    builder: (context, constraints) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${requestText} ",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .1,
                        ),
                        requestStatus == 1
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.greenAccent,
                                      ),
                                      onPressed: () async {
                                        await profileProvider
                                            .itemAccept(requestId)
                                            .then((value) => profileProvider
                                                    .successMessage!.isNotEmpty
                                                ? AwesomeDialog(
                                                        dialogType:
                                                            DialogType.SUCCES,
                                                        dismissOnTouchOutside:
                                                            false,
                                                        btnOkOnPress: () async {
                                                          await profileProvider
                                                              .getMyProductsRequests(
                                                                  profileProvider
                                                                      .itemIdForUpdate!);
                                                        },
                                                        body: Center(
                                                          child: Text(
                                                              '${profileProvider.successMessage}'),
                                                        ),
                                                        context: context)
                                                    .show()
                                                : AwesomeDialog(
                                                    context: context));
                                      },
                                      child: Text("قبول")),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .2,
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey,
                                      ),
                                      onPressed: () async {
                                        await profileProvider
                                            .iteReject(requestId)
                                            .then((value) => profileProvider
                                                    .successMessage!.isNotEmpty
                                                ? AwesomeDialog(
                                                        dialogType:
                                                            DialogType.SUCCES,
                                                        dismissOnTouchOutside:
                                                            false,
                                                        btnOkOnPress: () async {
                                                          await profileProvider
                                                              .getMyProductsRequests(
                                                                  profileProvider
                                                                      .itemIdForUpdate!);
                                                        },
                                                        body: Center(
                                                          child: Text(
                                                              '${profileProvider.successMessage}'),
                                                        ),
                                                        context: context)
                                                    .show()
                                                : AwesomeDialog(
                                                    context: context));
                                      },
                                      child: Text("رفض")),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .1,
                                  ),
                                ],
                              )
                            : requestStatus == 2
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.greenAccent,
                                          ),
                                          onPressed: () async {
                                            await profileProvider
                                                .itemFinish(requestId)
                                                .then((value) => profileProvider
                                                        .successMessage!
                                                        .isNotEmpty
                                                    ? AwesomeDialog(
                                                            dialogType:
                                                                DialogType
                                                                    .SUCCES,
                                                            dismissOnTouchOutside:
                                                                false,
                                                            btnOkOnPress:
                                                                () async {
                                                              await profileProvider
                                                                  .getMyProductsRequests(
                                                                      profileProvider
                                                                          .itemIdForUpdate!);
                                                            },
                                                            body: Center(
                                                              child: Text(
                                                                  '${profileProvider.successMessage}'),
                                                            ),
                                                            context: context)
                                                        .show()
                                                    : AwesomeDialog(
                                                        context: context));
                                          },
                                          child: Text("إنهاء")),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .2,
                                      ),
                                      ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey,
                                          ),
                                          onPressed: () async {
                                            await profileProvider
                                                .itemCancel(requestId)
                                                .then((value) => profileProvider
                                                        .successMessage!
                                                        .isNotEmpty
                                                    ? AwesomeDialog(
                                                            dialogType:
                                                                DialogType
                                                                    .SUCCES,
                                                            dismissOnTouchOutside:
                                                                false,
                                                            btnOkOnPress:
                                                                () async {
                                                              await profileProvider
                                                                  .getMyProductsRequests(
                                                                      profileProvider
                                                                          .itemIdForUpdate!);
                                                            },
                                                            body: Center(
                                                              child: Text(
                                                                  '${profileProvider.successMessage}'),
                                                            ),
                                                            context: context)
                                                        .show()
                                                    : AwesomeDialog(
                                                        context: context));
                                          },
                                          child: Text("تراجع")),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                .1,
                                      ),
                                    ],
                                  )
                                : requestStatus == 3
                                    ? Text("تم انهاء الطلب",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))
                                    : Row(
                                        children: [
                                          Icon(
                                            Icons.done,
                                            color: kTeal400,
                                            size: 25,
                                          ),
                                          Text(
                                            "تم تسليم الطلب بنجاح",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      )
                      ],
                    ),
                  ),
                  width: mdw,
                  height: mdh * 0.25,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 4),
                          blurRadius: 5,
                          color: index % 2 != 0 ? kTeal400 : Color(0xFF7e8f94),
                        )
                      ],
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(0),
                        bottomLeft: Radius.circular(0),
                        bottomRight: Radius.circular(0),
                      ),
                      color: index % 2 != 0 ? kTeal400 : Colors.grey),
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Positioned(
                top: mdh * 0,
                right: 0,
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(top: 3),
                        height: 85,
                        width: 85,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            // borderRadius: BorderRadius.all(Radius.circular(80)),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 5),
                                  blurRadius: 40,
                                  color: kTeal400.withOpacity(0.30))
                            ]),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(
                              requestClientImage,
                              fit: BoxFit.fill,
                            )),
                      ),
                    ),
                    Container(
                      child: Text(requestClient,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            //fontFamily: 'TrajanPro' )
                          )),
                    ),
                    Container(
                      child: Text(requestClientPhone,
                          style: TextStyle(
                            color: Colors.white,

                            fontSize: 9,
                            //fontFamily: 'TrajanPro' )
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

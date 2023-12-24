import 'package:flutter/material.dart';
import 'package:letshelp/provider/profile-provider.dart';
import 'package:letshelp/screens/my-items.dart';
import 'package:letshelp/screens/my-orders.dart';
import 'package:letshelp/screens/privatmessag.dart';
import 'package:letshelp/screens/requested-items-screen.dart';
import 'package:provider/provider.dart';
import '../provider/messagesp_povider.dart';
import '../theme/colors.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final mdw = MediaQuery.of(context).size.width;
    final mdh = MediaQuery.of(context).size.height;
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([profileProvider.getMyProfile()]),
        builder: (context, _) => profileProvider.getProfile!
            ? SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: Center(
                              child: Container(
                                width: mdw,
                                height: mdh * 0.40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(0),
                                      topLeft: Radius.circular(0),
                                      bottomLeft: Radius.circular(80),
                                      bottomRight: Radius.circular(80),
                                    ),
                                    color: kTeal400),
                              ),
                            ),
                          ),
                          Positioned(
                            top: mdh * .25,
                            left: mdw * .29,
                            child: Column(
                              children: [
                                Center(
                                  child: Container(
                                    height: 130,
                                    width: 130,
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
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          "${profileProvider.profileModel!.myImage}",
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                      "${profileProvider.profileModel!.name}",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                        //fontFamily: 'TrajanPro' )
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: mdh * 0.15,
                      ),
                      Column(
                        children: [
                          Container(
                            padding:
                                EdgeInsets.symmetric(horizontal: mdw * .01),
                            width: mdw,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Center(
                                    child: Text(
                                  'المعلومات الشخصية ',
                                  style: TextStyle(
                                      color: kTeal400,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .03),
                                IntrinsicHeight(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .01),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: kTeal400),
                                              onPressed: () async {
                                                Navigator.push(
                                                    context,
                                                    (MaterialPageRoute(
                                                      builder: (context) =>
                                                          MyItems(),
                                                    )));
                                              },
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(Icons.category),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .02,
                                                  ),
                                                  Text(
                                                      "${profileProvider.profileModel!.myProducts}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .02,
                                                  ),
                                                  Text(" : منتجاتي",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: kTeal400),
                                              onPressed: () async {
                                                Navigator.push(
                                                    context,
                                                    (MaterialPageRoute(
                                                        builder: (context) =>
                                                            RequestedItemsScreen())));
                                                await profileProvider
                                                    .myRequestedItem();
                                              },
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                      flex: 0,
                                                      child: Icon(
                                                          Icons.question_mark)),
                                                  // SizedBox(
                                                  //   width:
                                                  //   MediaQuery.of(context)
                                                  //       .size
                                                  //       .width *
                                                  //       .02,
                                                  // ),

                                                  Expanded(
                                                    child: Text(
                                                      "  طلبات المنتجات",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: kTeal400),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            MyOrders()));
                                              },
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Icon(Icons.reorder),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .06,
                                                  ),
                                                  Text(
                                                      "${profileProvider.profileModel!.myRequests}",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            .02,
                                                  ),
                                                  Text(": طلباتي",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .02),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          flex: 0,
                                          child: VerticalDivider(
                                            thickness: 1.2,
                                          )),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .01),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                    "${profileProvider.profileModel!.gender}",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .02,
                                                ),
                                                Text(" : الجنس   ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold)),
                                              ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .02),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                    flex: 0,
                                                    child: Text(
                                                        "${profileProvider.profileModel!.registerDate}",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                                Expanded(
                                                    child: Text(
                                                        " : تاريخ التسجيل ",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                              ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .02),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .02,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    .02),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Expanded(
                                                    flex: 0,
                                                    child: Container(
                                                        child: Text(
                                                            "${profileProvider.profileModel!.CompleteOrderRate}",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)))),
                                                Expanded(
                                                    child: Text(
                                                        " : معدل الاستجابة للطلبات",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold))),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        .03),
                                // SizedBox(height: MediaQuery.of(context).size.height*.02),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .02),
                          Center(
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(Icons.star),
                                        Icon(Icons.star),
                                        Icon(Icons.star),
                                        Icon(Icons.star),
                                        Icon(Icons.star),
                                      ]),
                                  Text("( تقيمي )")
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height * .03),
                          Container(
                            child: Consumer<MessagesProvider>(
                              builder: (context, messagesProvide, _) =>
                                  ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: kTeal400),
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PrivatMessage()),
                                  );
                                  await messagesProvide.getAllMessages();
                                },
                                child: Text(" صندوق الوارد  ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold, fontSize: 23,
                                      //fontFamily: 'TrajanPro' )
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                color: kTeal400,
              )),
      ),
    );
  }
}

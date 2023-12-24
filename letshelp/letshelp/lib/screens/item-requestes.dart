// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:letshelp/provider/profile-provider.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';
import '../widgets/item-request-widget.dart';

class ItemRequestes extends StatelessWidget {
  ItemRequestes({Key? key, this.title}) : super(key: key);
  String? title = "فلنتساعد ...";
  @override
  Widget build(BuildContext context) {
    final mdw = MediaQuery.of(context).size.width;
    final mdh = MediaQuery.of(context).size.height;
    return Consumer<ProfileProvider>(
        builder: (context, profileProvider, _) => Scaffold(
              appBar: AppBar(
                backgroundColor: kTeal400,
                elevation: 3.0,
                title: Text(
                  '$title',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              body: profileProvider.isGetRequests
                  ? ListView(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          child: IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    profileProvider.requestsFilter = false;
                                    await profileProvider.getMyProductsRequests(
                                        profileProvider.itemIdForUpdate!);
                                  },
                                  child: Text(
                                    "المقبولة",
                                    style: TextStyle(
                                        color: kTeal400,
                                        fontWeight:
                                            profileProvider.requestsFilter
                                                ? FontWeight.normal
                                                : FontWeight.bold,
                                        fontSize: profileProvider.requestsFilter
                                            ? 13
                                            : 18),
                                  ),
                                ),
                                VerticalDivider(
                                  thickness: 3,
                                ),
                                InkWell(
                                  onTap: () async {
                                    profileProvider.requestsFilter = true;
                                    await profileProvider.getMyProductsRequests(
                                        profileProvider.itemIdForUpdate!);
                                  },
                                  child: Text(" المعلقة",
                                      style: TextStyle(
                                          color: kTeal400,
                                          fontWeight:
                                              profileProvider.requestsFilter
                                                  ? FontWeight.bold
                                                  : FontWeight.normal,
                                          fontSize:
                                              profileProvider.requestsFilter
                                                  ? 18
                                                  : 13)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        profileProvider.myRequests.length == 0
                            ? SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * .35,
                              )
                            : Container(),
                        Container(
                          child: profileProvider.myRequests.length == 0
                              ? Center(
                                  child: Text("لايوجد طلبات لهذا المنتج"),
                                )
                              : Container(
                                  // height: MediaQuery.of(context).size.height,
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: ListView.separated(
                                      physics: ScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return ItemRequestW(
                                          requestClient: profileProvider
                                              .myRequests[index].requestClient,
                                          requestClientImage: profileProvider
                                              .myRequests[index]
                                              .requestClientImage,
                                          requestClientPhone: profileProvider
                                              .myRequests[index]
                                              .requestClientPhone,
                                          requestId: profileProvider
                                              .myRequests[index].requestId,
                                          requestStatus: profileProvider
                                              .myRequests[index].requestStatus,
                                          requestText: profileProvider
                                              .myRequests[index].requestText,
                                          index: index,
                                          mdh: mdh,
                                          mdw: mdw,
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.02,
                                        );
                                      },
                                      itemCount:
                                          profileProvider.myRequests.length),
                                ),
                        ),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(
                        color: kTeal400,
                      ),
                    ),
            ));
  }
}

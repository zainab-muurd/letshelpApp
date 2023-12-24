import 'package:flutter/material.dart';
import 'package:letshelp/provider/messagesp_povider.dart';
import 'package:letshelp/widgets/single-message.dart';
import 'package:provider/provider.dart';

import '../theme/colors.dart';
import '../widgets/messageAvatar.dart';

class PrivatMessage extends StatefulWidget {
  const PrivatMessage({Key? key}) : super(key: key);

  @override
  State<PrivatMessage> createState() => _PrivatMessageState();
}

class _PrivatMessageState extends State<PrivatMessage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MessagesProvider>(
      builder: (context, messageProvider, _) => WillPopScope(
        onWillPop: messageProvider.editBackButton,
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: kTeal400,
                title: Text(
                  "صندوق الوارد  ",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )),
            body: Consumer<MessagesProvider>(
              builder: (context, messageProvider, _) => SingleChildScrollView(
                controller: messageProvider.singleChildScroll,
                physics: AlwaysScrollableScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: messageProvider.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : Column(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.19,
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return MessageAvatar(
                                      name: messageProvider
                                          .messagePerson[index].name
                                          .toString(),
                                      url: messageProvider
                                          .messagePerson[index].imageUrl
                                          .toString(),
                                      id: messageProvider
                                          .messagePerson[index].id as int,
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      width: 10,
                                    );
                                  },
                                  itemCount:
                                      messageProvider.messagePerson.length,
                                  scrollDirection: Axis.horizontal,
                                ),
                              ),
                              messageProvider.isMessageChose
                                  ? Column(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5, horizontal: 5),
                                            color: kGrey501,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text(
                                                  messageProvider.name!,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: kTeal400),
                                                ),
                                                SizedBox(
                                                  width: 9,
                                                ),
                                                Container(
                                                  width: 60.0,
                                                  height: 60.0,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xff7c94b6),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          messageProvider
                                                              .image!),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50.0)),
                                                    border: Border.all(
                                                      color: kTeal400,
                                                      width: 4.0,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 20),
                                            child: ListView.separated(
                                              itemBuilder: (context, index) {
                                                return SingleMessageW(
                                                    message: messageProvider
                                                        .singleMessage[index]
                                                        .message,
                                                    id: messageProvider
                                                        .singleMessage[index]
                                                        .id,
                                                    isSender: messageProvider
                                                        .singleMessage[index]
                                                        .isSender);

                                                //Text(
                                                //     "${messageProvider.singleMessage[index].message}");
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(
                                                  height: 15,
                                                );
                                              },
                                              controller: messageProvider
                                                  .scrollController,
                                              itemCount: messageProvider
                                                  .singleMessage.length,
                                              shrinkWrap: true,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : messageProvider.isFirsTime
                                      ? Column(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .2,
                                            ),
                                            Center(
                                              child: Text(
                                                  "اضغط على المحادثة لعرض المحتوى "),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .2,
                                            ),
                                            Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            ),
                                          ],
                                        ),
                              messageProvider.isMessageChose
                                  ? Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              blurRadius: 3.0,
                                            ),
                                          ]),
                                      child: Row(
                                        children: [
                                          Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.85,
                                              child: TextFormField(
                                                controller: messageProvider
                                                    .messageTosend,
                                                textAlign: TextAlign.end,
                                                decoration: InputDecoration(
                                                  hintText: 'إرسال رسالة ',
                                                  fillColor: Colors.white,
                                                  //    filled: true,
                                                ),
                                              )),
                                          IconButton(
                                              icon: Icon(Icons.send, size: 30),
                                              onPressed: () async {
                                                await messageProvider
                                                    .sendMessage()
                                                    .then((value) =>
                                                        messageProvider
                                                            .scrollDown());
                                              }),
                                        ],
                                      ),
                                    )
                                  : Container()
                            ],
                          )),
              ),
            )),
      ),
    );
  }
}

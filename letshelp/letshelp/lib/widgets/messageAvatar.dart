import 'package:flutter/material.dart';
import 'package:letshelp/provider/messagesp_povider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MessageAvatar extends StatelessWidget {
  MessageAvatar(
      {Key? key, required this.name, required this.url, required this.id})
      : super(key: key);

  String name;
  String url;
  int id;

  @override
  Widget build(BuildContext context) {
    return Consumer<MessagesProvider>(
      builder: (context, messageProvider, _) => Column(
        children: [
          InkWell(
            onTap: () async {
              if (messageProvider.isTimerOn!) {
                messageProvider.timerFotSingleConversation!.cancel();
              }

              await messageProvider.getConversationById(this.id);

              messageProvider.name = this.name;
              messageProvider.image = this.url;
              messageProvider.messageId = this.id;
            },
            child: ClipOval(
              child: Image.network(
                url,
                width: 73,
                height: 73,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            name,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}

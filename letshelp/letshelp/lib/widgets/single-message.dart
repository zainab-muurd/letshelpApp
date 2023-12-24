// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class SingleMessageW extends StatelessWidget {
  SingleMessageW(
      {Key? key,
      required this.message,
      required this.id,
      required this.isSender})
      : super(key: key);
  String? message;
  int? id;
  bool? isSender;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isSender! ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: isSender! ? Color(0xffe8f1f3) : Color(0xffcae9e9),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
                color: isSender! ? Color(0xffe8f1f3) : Color(0xffcae9e9)),
          ),
          child: Text(message!),
        ),
      ],
    );
  }
}

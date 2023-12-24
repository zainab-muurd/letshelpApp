import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../theme/colors.dart';

class LestHelpForum extends StatefulWidget {
  LestHelpForum({Key? key}) : super(key: key);

  @override
  State<LestHelpForum> createState() => _LestHelpForumState();
}

class _LestHelpForumState extends State<LestHelpForum> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool _isLoading = true;
  final _key = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kTeal400,
          elevation: 3.0,
          title: Text(
            'المنتدى',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: Stack(
          children: [
            WebView(
              key: _key,
              initialUrl: "https://forum.letshelp-platform.com/",
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController controller) {
                _controller.complete(controller);
              },
              onPageFinished: (url) {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
            _isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(),
          ],
        ),
      ),
    );
  }
}

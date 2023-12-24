import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../theme/colors.dart';

class LetsHelpCommonQuestions extends StatelessWidget {
  LetsHelpCommonQuestions({Key? key}) : super(key: key);

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kTeal400,
          elevation: 3.0,
          title: Text(
            'الاسئلة الشائعة',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: WebView(
          initialUrl: "https://letshelp-platform.com/faq",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}

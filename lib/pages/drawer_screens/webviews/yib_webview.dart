import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YibWebView extends StatefulWidget {
  const YibWebView({super.key});

  @override
  State<YibWebView> createState() => _YibWebViewState();
}

class _YibWebViewState extends State<YibWebView> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse('https://yibd.org/'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

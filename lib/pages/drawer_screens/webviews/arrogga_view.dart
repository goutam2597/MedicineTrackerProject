import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AroggaWebView extends StatefulWidget {
  const AroggaWebView({super.key});

  @override
  State<AroggaWebView> createState() => _AroggaWebViewState();
}

class _AroggaWebViewState extends State<AroggaWebView> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.disabled)
    ..loadRequest(Uri.parse('https://arogga.com/'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}

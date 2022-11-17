import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/provider/news_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewsScreen extends StatefulWidget {
  const WebViewsScreen({
    required this.newsUrl,
    Key? key}) : super(key: key);

  final String newsUrl;

  @override
  State<WebViewsScreen> createState() => _WebViewsScreenState();
}

class _WebViewsScreenState extends State<WebViewsScreen> {
  NewsProvider newsProvider = NewsProvider();
  final Completer<WebViewController> controller = Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.newsUrl,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController){
          setState(() {
            controller.complete(webViewController);
          });
        },

      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FullNewsPage extends StatefulWidget {
  final String url;
  final String title;

  FullNewsPage({Key? key, required this.url, required this.title}) : super(key: key);

  @override
  _FullNewsPageState createState() => _FullNewsPageState();
}

class _FullNewsPageState extends State<FullNewsPage> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Optional: update loading progress indicator
            print("Loading progress: $progress%");
          },
          onPageStarted: (String url) {
            print("Page started loading: $url");
          },
          onPageFinished: (String url) {
            print("Page finished loading: $url");
          },
          onHttpError: (HttpResponseError error) {
            print("HTTP error: ${error}");
          },
          onWebResourceError: (WebResourceError error) {
            print("Web resource error: ${error.description}");
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              print("Navigation blocked to: ${request.url}");
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}

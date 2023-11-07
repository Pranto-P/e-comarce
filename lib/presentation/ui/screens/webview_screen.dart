import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewScreen extends StatefulWidget {
  const WebviewScreen({Key? key, required this.paymentUrl}) : super(key: key);

  final String paymentUrl;

  @override
  State<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends State<WebviewScreen> {
  late final WebViewController _webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse(widget.paymentUrl));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('payment'),
      ),
      body: WebViewWidget(
          controller: _webViewController),
    );
  }
}

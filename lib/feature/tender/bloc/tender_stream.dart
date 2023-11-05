import 'package:flutter/material.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class TenderStream extends StatefulWidget {
  const TenderStream({super.key});

  @override
  State<TenderStream> createState() => _TenderStreamState();
}

class _TenderStreamState extends State<TenderStream> {
  WebViewPlusController? _controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebViewPlus(
          javascriptMode: JavascriptMode.unrestricted,
          gestureNavigationEnabled: true,
          onWebViewCreated: (controller){
            _controller = controller;
          },
          initialUrl: 'http://192.168.43.93:8080/organizations',
        ),
      ),
    );
  }
}

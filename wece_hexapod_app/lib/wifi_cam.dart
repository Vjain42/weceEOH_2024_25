import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CameraStreamPage extends StatefulWidget {
  const CameraStreamPage({Key? key}) : super(key: key);
  @override
  _CameraStreamPageState createState() => _CameraStreamPageState();
}

class _CameraStreamPageState extends State<CameraStreamPage> {
  late final WebViewController _controller;

  final String esp32StreamUrl = "http://192.168.1.11"; // Replace with actual IP

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(esp32StreamUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ESP32 Camera Stream")),
      body: WebViewWidget(controller: _controller),
    );
  }
}

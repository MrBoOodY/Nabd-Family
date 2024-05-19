import 'package:flutter/material.dart';
import 'package:nabd_family/login_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage({super.key, required this.controller});

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) async {
        if (await controller.canGoBack()) {
          controller.goBack();
        } else {
          if (context.mounted) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ),
              (route) => true,
            );
          }
        }
      },
      child: Scaffold(
        body: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }
}

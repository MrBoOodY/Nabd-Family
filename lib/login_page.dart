import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nabd_family/web_view_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final WebViewController normalController;
  late final WebViewController employeeController;
  Future<WebViewController> createControllers(String url) async {
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000));
    await controller.loadRequest(Uri.parse(url));
    return controller;
  }

  @override
  void initState() {
    createControllers('https://apps.thenabd.com.sa/ar/login').then(
      (value) {
        normalController = value;
        createControllers('https://apps.thenabd.com.sa/ar/employee/login').then(
          (value) {
            employeeController = value;
            FlutterNativeSplash.remove();
          },
        );
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/bg.png'),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/logo.png",
                      width: 400, height: 300, fit: BoxFit.fitWidth),
                  const SizedBox(height: 20),
                  const Text('اهلا بك ...',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  const SizedBox(height: 20),
                  const Text('اختار نوع حسابك',
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10),
                          backgroundColor: const Color(0xff0893cb),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebViewPage(controller: normalController),
                            ));
                      },
                      child: const Text('التسجيل كعميل',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(10),
                          backgroundColor: const Color(0xff4cb050),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WebViewPage(controller: employeeController),
                            ));
                      },
                      child: const Text('التسجيل كموظف',
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

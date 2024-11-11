import 'package:flutter/material.dart';
import 'package:loading_dialog/page/loading_dialog_page.dart';
import 'package:loading_dialog/page/loading_overlay_page.dart';
import 'package:loading_dialog/page/third_page.dart';

import 'page/fourth_page.dart';

void main() {
  runApp(MyApp());
  // runApp(OverApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/LoadingDialogPage': (context) => LoadingDialogPage(),
        '/LoadingOverlayPage': (context) => LoadingOverlayPage(),
        '/ThirdPage': (context) => ThirdPage(),
        '/FourthPage': (context) => FourthPage(),
      },
    );
    // return MaterialApp.router(
    // );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/LoadingDialogPage');
              },
              child: const Text("다이얼로그 로딩 페이지"),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/LoadingOverlayPage');
              },
              child: const Text("Overlay 로딩 페이지"),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

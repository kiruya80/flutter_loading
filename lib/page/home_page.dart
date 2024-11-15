import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_dialog/page/loading_dialog_page.dart';
import 'package:loading_dialog/page/loading_overlay_page.dart';

import '../base/state_navigator.dart';

///
/// 생성일 : 2024. 11. 15.
/// class 설명
///
///

class HomePage extends ConsumerStatefulWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends StateNavigator<HomePage> {
  @override
  void readyWidget() {
    // TODO: implement readyWidget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('route : ${currentRoute?.settings.name} [${routeStack.length}'),
            Text('tempRouteList : ${tempRouteList}'),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async {
                // Navigator.pushNamed(context, '/LoadingDialogPage');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoadingDialogPage(),
                        settings: const RouteSettings(name: '/LoadingDialogPage')));
              },
              child: const Text("다이얼로그 로딩 페이지"),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/LoadingOverlayPage');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoadingOverlayPage(),
                        settings: const RouteSettings(name: '/LoadingOverlayPage')));
              },
              child: const Text("Overlay 로딩 페이지"),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/LoadingOverlayPage');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoadingOverlayPage(),
                        settings: const RouteSettings(name: '/NotifierFirstPage')));
              },
              child: const Text("NotifierFirstPage"),
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

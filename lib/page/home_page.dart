import 'package:flutter/material.dart';
import 'package:loading_dialog/page/riverpod/loading_consumer_dialog_page.dart';
import 'package:loading_dialog/page/riverpod/loading_overlay_page.dart';

import '../base/route/route_state.dart';

///
/// 생성일 : 2024. 11. 15.
/// class 설명
///
///

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends RouteState<HomePage> {
  @override
  void readyWidget() {
    // TODO: implement readyWidget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('route : ${currentRoute?.settings.name} [${routeStack.length}'),
            // Text('tempRouteList : ${tempRouteList}'),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
              child: TextField(),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text('flutter StatefulWidget'),

            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/LoadingDialogPage');
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => LoadingDialogPage(),
                //         settings:
                //         const RouteSettings(name: '/LoadingDialogPage')));
              },
              child: const Text("다이얼로그 로딩 페이지"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/ThirdPage');
              },
              child: const Text("ThirdPage"),
            ),

            const SizedBox(
              height: 30,
            ),
            Text('riverpod ConsumerStatefulWidget'),

            ElevatedButton(
              onPressed: () async {
                // Navigator.pushNamed(context, '/LoadingDialogPage');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoadingConsumerDialogPage(),
                        settings: const RouteSettings(
                            name: '/LoadingConsumerDialogPage')));
              },
              child: const Text("다이얼로그 로딩 페이지"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.pushNamed(context, '/ThirdConsumerPage');
              },
              child: const Text("ThirdConsumerPage"),
            ),

            const SizedBox(
              height: 30,
            ),
            Text('Overlay'),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/LoadingOverlayPage');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoadingOverlayPage(),
                        settings:
                            const RouteSettings(name: '/LoadingOverlayPage')));
              },
              child: const Text("Overlay 로딩 페이지"),
            ),
            const SizedBox(
              height: 30,
            ),
            Text('NotifierFirstPage'),
            ElevatedButton(
              onPressed: () {
                // Navigator.pushNamed(context, '/LoadingOverlayPage');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoadingOverlayPage(),
                        settings:
                            const RouteSettings(name: '/NotifierFirstPage')));
              },
              child: const Text("NotifierFirstPage"),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}

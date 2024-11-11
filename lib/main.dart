import 'package:flutter/material.dart';
import 'package:loading_dialog/page/loading_dialog_page.dart';
import 'package:loading_dialog/page/loading_overlay_page.dart';
import 'package:loading_dialog/page/third_page.dart';
import 'package:loading_dialog/util/print_log.dart';

import 'my_navigator_observer.dart';
import 'page/fourth_page.dart';

void main() {
  runApp(MyApp());
  // runApp(OverApp());
}

var route = MaterialPageRoute(builder: (context) => LoadingDialogPage());

class MyApp extends StatelessWidget {
  final MyNavigatorObserver myObserver = MyNavigatorObserver();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [myObserver],
      // 옵저버 등록
      home: HomePage(),
    );

    // return MaterialApp(
    //   initialRoute: '/',
    //   routes: {
    //     '/': (context) => HomePage(),
    //     '/LoadingDialogPage': (context) => LoadingDialogPage(),
    //     '/LoadingOverlayPage': (context) => LoadingOverlayPage(),
    //     '/ThirdPage': (context) => ThirdPage(),
    //     '/FourthPage': (context) => FourthPage(),
    //   },
    // routes: <String, WidgetBuilder> {
    //   '/': (BuildContext context) => new HomePage(),
    //   '/LoadingDialogPage' : (BuildContext context) => new LoadingDialogPage(),
    //   '/LoadingOverlayPage' : (BuildContext context) => new LoadingOverlayPage(),
    //   '/ThirdPage' : (BuildContext context) => new ThirdPage(),
    //   '/FourthPage' : (BuildContext context) => new FourthPage()
    // },
    // );
    // return MaterialApp.router(
    // );
  }
}

class HomePage extends StatelessWidget {
  // 구독자 1

  @override
  Widget build(BuildContext context) {
    final myObserver = (context.findAncestorWidgetOfExactType<MyApp>() as MyApp).myObserver;

    myObserver.currentPathStream.listen((v) {
      QcLog.d('currentPathStream ===== [${v.length}] ,  $v , ');

      // final currentRoute = ModalRoute.of(context);
      // QcLog.i('Current Route: ${currentRoute?.settings.name} , ${currentRoute.toString()}');

    });
    myObserver.routeStackStream.listen((v) {
      QcLog.d('routeStackStream =====  [${v.length}] , $v ');

      // final currentRoute = ModalRoute.of(context);
      // QcLog.i('Current Route: ${currentRoute?.settings.name} , ${currentRoute.toString()}');

    });
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                // Navigator.pushNamed(context, '/LoadingDialogPage');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LoadingDialogPage(),
                        settings: RouteSettings(name: 'LoadingDialogPage')));
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
                        settings: RouteSettings(name: 'LoadingOverlayPage')));
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

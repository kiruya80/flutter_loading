import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_dialog/page/loading_dialog_page.dart';
import 'package:loading_dialog/page/loading_overlay_page.dart';
import 'package:loading_dialog/page/notifier_first_page.dart';
import 'package:loading_dialog/page/notifier_second_page.dart';
import 'package:loading_dialog/page/third_page.dart';

import 'navigator/navigator_observer_notifier.dart';
import 'over_app.dart';
import 'page/fourth_page.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => HomePage(),
  '/LoadingDialogPage': (context) => LoadingDialogPage(),
  '/LoadingOverlayPage': (context) => LoadingOverlayPage(),
  '/ThirdPage': (context) => ThirdPage(),
  '/FourthPage': (context) => FourthPage(),

  '/NotifierFirstPage': (context) => NotifierFirstPage(),
  '/NotifierSecondPage': (context) => NotifierSecondPage(),
};

void main() {
  // runApp(MyApp());
  runApp(ProviderScope(child: MyApp()));
  // runApp(ProviderScope(child: SampleRouteObserverRiverpod()));
  // runApp(OverApp());
}

// var route = MaterialPageRoute(builder: (context) => LoadingDialogPage());

class MyApp extends ConsumerWidget {
  // final MyNavigatorObserver myObserver = MyNavigatorObserver();
  // final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final navigatorObserver = ref.watch(myNavigatorObserverProvider);
    // QcLog.d('MyApp ===  ${navigatorObserver.toString()}');

    // final navigatorObserver = ref.watch(navigatorObserverNotifier);
    // QcLog.d('LoadingDialogPage ===  ${navigatorObserver.routeStack.toString()}');
    // QcLog.d('routeStack length ===  ${navigatorObserver.routeStack.length}');

    // final navigatorChangeObserver = ref.watch(myNavigatorObserverChangeProvider);
    // QcLog.d('MyApp ===  ${navigatorChangeObserver.toString()}');

    // final routeObserver = ref.watch(routeObserverProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // navigatorObservers: [myObserver],
      // navigatorObservers: [navigatorObserver],
      navigatorObservers: [ref.watch(navigatorObserverNotifier)],
      routes: routes,
      // 옵저버 등록
      // home: HomePage(),
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

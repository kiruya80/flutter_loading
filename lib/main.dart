import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_dialog/page/flutter/loading_dialog_page.dart';
import 'package:loading_dialog/page/home_page.dart';
import 'package:loading_dialog/page/riverpod/fourth_consumer_page.dart';
import 'package:loading_dialog/page/riverpod/loading_consumer_dialog_page.dart';
import 'package:loading_dialog/page/riverpod/loading_overlay_page.dart';
import 'package:loading_dialog/page/riverpod/notifier_first_page.dart';
import 'package:loading_dialog/page/riverpod/notifier_second_page.dart';
import 'package:loading_dialog/page/flutter/third_page.dart';
import 'package:loading_dialog/page/riverpod/third_consumer_page.dart';

import 'navigator/navigator_stream_observer.dart';
import 'page/flutter/fourth_page.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => HomePage(),
  '/LoadingDialogPage': (context) => LoadingDialogPage(),
  '/ThirdPage': (context) => ThirdPage(),
  '/FourthPage': (context) => FourthPage(),
  '/LoadingConsumerDialogPage': (context) => LoadingConsumerDialogPage(),
  '/ThirdConsumerPage': (context) => ThirdConsumerPage(),
  '/FourthConsumerPage': (context) => FourthConsumerPage(),
  '/LoadingOverlayPage': (context) => LoadingOverlayPage(),
  '/NotifierFirstPage': (context) => NotifierFirstPage(),
  '/NotifierSecondPage': (context) => NotifierSecondPage(),
};

void main() {
  // runApp(MyApp());
  runApp(ProviderScope(child: MyApp()));
  // runApp(ProviderScope(child: SampleRouteObserverRiverpod()));
  // runApp(OverApp());
}

// myObserver = (context.findAncestorWidgetOfExactType<MyApp>() as MyApp).myObserver;
// var route = MaterialPageRoute(builder: (context) => LoadingDialogPage());

class MyApp extends ConsumerWidget {
  final NavigatorStreamObserver streamObserver = NavigatorStreamObserver();
  final RouteObserver routeObserver = RouteObserver();

  // final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  // NavigatorObserverNotifier navigatorObserver = NavigatorObserverNotifier();
  // AutoRouteObserver aRouteObserver = AutoRouteObserver();

  /**
   *
      // final navigatorObserver = ref.watch(myNavigatorObserverProvider);
      // QcLog.d('MyApp ===  ${navigatorObserver.toString()}');

      // final navigatorObserver = ref.watch(navigatorObserverNotifier);

      // final navigatorChangeObserver = ref.watch(myNavigatorObserverChangeProvider);
      // QcLog.d('MyApp ===  ${navigatorChangeObserver.toString()}');

      // final routeObserver = ref.watch(routeObserverProvider);
   */
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1.
    // navigatorObserver.addListener((){
    //   QcLog.d('navigatorObserver ==== ${navigatorObserver.currentRoute.toString()}');
    // });
    // 2.
    // final navigatorObserver = ref.watch(navigatorObserverNotifier);

    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [streamObserver, routeObserver],
      // navigatorObservers: [RouteObserver()],
      // navigatorObservers: [navigatorObserver],
      // navigatorObservers: [ref.watch(navigatorObserverNotifier)],
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

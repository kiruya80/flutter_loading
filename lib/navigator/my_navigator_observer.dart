import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:loading_dialog/util/print_log.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
///
/// route 옵져버
///
/// 참고
/// https://medium.com/@atefelsaid3/mastering-navigation-tracking-in-flutter-a-complete-guide-to-routeobserver-with-riverpod-ea23a12fb80c
///
//   myObserver = (context.findAncestorWidgetOfExactType<MyApp>() as MyApp).myObserver;
//
//   /// 현재 패스
//   myObserver?.currentRouteStream.listen((route) {
//     QcLog.d('currentRouteStream ===== [${route?.settings.name}] , ');
//     currentRoute = route;
//   });
//
//   myObserver?.routeStackStream.listen((stackRoute) {
//     QcLog.d('routeStackStream =====  [${stackRoute.length}] ');
//     routeStack = stackRoute;
//     int index = 0;
//     for (var route in stackRoute) {
//       print(
//           'stackRoute $index ========= ${route.settings.name} , ${route.isActive} , ${route.isCurrent}');
//       print('route info ================ ${route.toString()}');
//       index++;
//     }
//   });
class MyNavigatorObserver extends NavigatorObserver {
  final List<Route> routeStack = [];

  Stream<List<Route>> get routeStackStream => _stackStreamController.stream;
  final _stackStreamController = StreamController<List<Route>>.broadcast();

  Stream<Route?> get currentRouteStream => _streamController.stream;
  final _streamController = StreamController<Route?>.broadcast();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    int oldStack = routeStack.length;

    routeStack.add(route);
    _stackStreamController.add(routeStack);
    // _stackStreamController.add([route]);

    _printStack();
    _streamController.add(route);
    // final nowRoute = route.settings.name;
    // if (nowRoute != null) _streamController.add(nowRoute);

    QcLog.i("""[Push 정보 (route stack : $oldStack > ${routeStack.length})]
        이전 라우트: ${previousRoute?.settings.name}
        >> [현재 라우트: ${route.settings.name}]""");
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    int oldStack = routeStack.length;

    routeStack.remove(route);
    _stackStreamController.add(routeStack);
    // _stackStreamController.add([route]);

    _printStack();

    _streamController.add(previousRoute);
    // _streamController.add(previousRoute?.settings.name ?? "/");
    QcLog.i("""[Pop 정보 (route stack : $oldStack > ${routeStack.length})]
        현재 라우트: ${route.settings.name} 제거
        >>> [이전 라우트: ${previousRoute?.settings.name}] 노출 """);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    int oldStack = routeStack.length;

    routeStack.remove(route);
    // _streamController.add(previousRoute);
    _printStack();

    QcLog.i("""[Remove 정보 (route stack : $oldStack > ${routeStack.length})]
        현재 라우트: ${route.settings.name}
        >>> [이전 라우트: ${previousRoute?.settings.name}] """);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    int oldStack = routeStack.length;

    if (oldRoute != null) {
      routeStack.remove(oldRoute);
    }
    if (newRoute != null) {
      routeStack.add(newRoute);
      _streamController.add(newRoute);
    }
    _stackStreamController.add(routeStack);
    _printStack();

    QcLog.i("""[Replace 정보 (route stack : $oldStack > ${routeStack.length})]
      이전 라우트: ${oldRoute?.settings.name}
        >>> [현재 라우트: ${newRoute?.settings.name}]""");
  }

  void dispose() {
    _streamController.close();
    _stackStreamController.close();
  }

  void _printStack() {
    print('┌─────────── Current Navigator stack ──────────────');
    // print("======= Current Navigator stack ======= ");
    for (var route in routeStack) {
      print('Route Name : ${route.settings.name}');
      print('            isFirst: ${route.isFirst} /  isActive: ${route.isActive} /'
          ' isCurrent: ${route.isCurrent} /  overlayEntries: ${route.overlayEntries.length} /'
          'settings: ${route.settings.toString()} /'
          ' ');
    }
  }
}

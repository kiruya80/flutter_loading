import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'base_navigator_observer.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
///
/// route 옵져버
/// ㄴ 라우터의 스택과 현재 라우터등 가져오기 위해서
///
/// 참고
/// https://medium.com/@atefelsaid3/mastering-navigation-tracking-in-flutter-a-complete-guide-to-routeobserver-with-riverpod-ea23a12fb80c
///
//   streamObserver = (context.findAncestorWidgetOfExactType<MyApp>() as MyApp).streamObserver;
//
//   /// 현재 패스
//   myObserver?.currentRouteStream.listen((route) {
//     QcLog.d('currentRouteStream ===== [${route?.settings.name}] , ');
//     currentRoute = route;
//   });
//
//   streamObserver?.routeStackStream.listen((stackRoute) {
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
// class NavigatorStreamObserver extends RouteObserver {
class NavigatorStreamObserver extends BaseNavigatorObserver {
  Stream<List<Route>> get routeStackStream => _stackStreamController.stream;
  final _stackStreamController = StreamController<List<Route>>.broadcast();

  Stream<Route?> get currentRouteStream => _streamController.stream;
  final _streamController = StreamController<Route?>.broadcast();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _stackStreamController.add(routeStack);
    _streamController.add(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _stackStreamController.add(routeStack);
    // _stackStreamController.add([route]);
    _streamController.add(previousRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    routeStack.remove(route);
    if (previousRoute != null) {
      _streamController.add(previousRoute);
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null) {
      _streamController.add(newRoute);
    }
    _stackStreamController.add(routeStack);
  }

  void dispose() {
    _streamController.close();
    _stackStreamController.close();
  }
}

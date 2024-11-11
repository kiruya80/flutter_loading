import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:loading_dialog/util/print_log.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
/// 
///
class MyNavigatorObserver extends NavigatorObserver {
  Stream<String> get currentPathStream => _streamController.stream;

  final _streamController = StreamController<String>.broadcast();

  final List<Route> routeStack = []; // Track routes
  Stream<List<Route>> get routeStackStream => _stackStreamController.stream;
  final _stackStreamController = StreamController<List<Route>>.broadcast();

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    if (previousRoute != null) {
      QcLog.i("""[Push 정보]
        이전 라우트: ${previousRoute.settings.name}
        현재 라우트: ${route.settings.name}""");
    }
    routeStack.add(route);
    // _stackStreamController.add(routeStack);
    _stackStreamController.add([route]);

    _printStack();
    final nowRoute = route.settings.name;
    if (nowRoute != null) _streamController.add(nowRoute);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null) {
      QcLog.i("""[Pop 정보]
        이전 라우트: ${previousRoute.settings.name}
        현재 라우트: ${route.settings.name}""");
    }
    routeStack.remove(route);
    _stackStreamController.add([route]);
    // _stackStreamController.add(routeStack);

    _printStack();
    _streamController.add(previousRoute?.settings.name ?? "/");
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    routeStack.remove(route);
    _printStack();
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (oldRoute != null) {
      routeStack.remove(oldRoute);
    }
    if (newRoute != null) {
      routeStack.add(newRoute);
    }
    _printStack();
    QcLog.i('Replaced ${oldRoute?.settings.name} with ${newRoute?.settings.name}'); // 페이지가 대체될 때 출력
  }

  void dispose() {
    _streamController.close();
    _stackStreamController.close();
  }

  void _printStack() {
    print('┌─────────── Current Navigator stack ──────────────');
    // print("======= Current Navigator stack ======= ");
    for (var route in routeStack) {
      print('Route Name : ${route.settings.name}' );
      print('            isFirst: ${route.isFirst} /  isActive: ${route.isActive} /'
          ' isCurrent: ${route.isCurrent} /  overlayEntries: ${route.overlayEntries.length} /'
          'settings: ${route.settings.toString()} /'
          ' ');
    }
  }
}

// class CommonRouteObserver extends NavigatorObserver {
//   Stream<String> get pathStream => _streamController.stream;
//
//   Stream<ExamplePageData?> get pageDataStream =>
//       pathStream.map((path) => ExamplePageList.findPageByPath(path));
//
//   final _streamController = StreamController<String>.broadcast();
//
//   @override
//   void didPush(Route route, Route? previousRoute) {
//     super.didPush(route, previousRoute);
//     final nowRoute = route.settings.name;
//     if (nowRoute != null) _streamController.add(nowRoute);
//   }
//
//   @override
//   void didPop(Route route, Route? previousRoute) {
//     super.didPop(route, previousRoute);
//     _streamController.add(previousRoute?.settings.name ?? "/");
//   }
// }
//
// interface class ExamplePageList {
//   static const all = [
//     NaverMapViewOptionsExample.pageData,
//     NOverlayExample.pageData,
//     CameraUpdateExample.pageData,
//     NaverMapPickExample.pageData,
//     NaverMapControllerExample.pageData,
//     NewWindowTestPage.pageData,
//   ];
//
//   static ExamplePageData? findPageByPath(String path) {
//     if (path == "/") return null;
//     for (final page in all) {
//       if (page.route == path) return page;
//     }
//     return null;
//   }
// }

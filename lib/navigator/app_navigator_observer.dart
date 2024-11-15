import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_dialog/util/print_log.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
///
/// route 옵져버
///
///
///
// 현재 활성화된 라우트 이름을 저장하는 StateProvider
final currentRouteProvider = StateProvider<String?>((ref) => null);

final appNavigatorObserver = Provider<NavigatorObserver>((ref) {
  QcLog.e('AppNavigatorObserver Provider === ');
  return AppNavigatorObserver(ref as WidgetRef);
});

class AppNavigatorObserver extends NavigatorObserver {

  final WidgetRef ref;

  AppNavigatorObserver(this.ref);


  List<Route> routeStack = [];
  Route? currentRoute;

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    int oldStack = routeStack.length;

    routeStack.add(route);
    currentRoute = route;
    _printStack();
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
    currentRoute = route;
    _printStack();

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
    currentRoute = previousRoute;
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
      currentRoute = newRoute;
    }
    _printStack();

    QcLog.i("""[Replace 정보 (route stack : $oldStack > ${routeStack.length})]
      이전 라우트: ${oldRoute?.settings.name}
        >>> [현재 라우트: ${newRoute?.settings.name}]""");
  }

  void dispose() {
    QcLog.d('dispose navigatorObserverNotifier =============');
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

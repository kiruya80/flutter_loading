import 'package:flutter/cupertino.dart';
import 'package:loading_dialog/util/print_log.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
///
/// route 옵져버
///
/// 라우터 스택과 네비게이터에서 라우터 스택등 체크를 위해서
///
/// 현재 라우터가 어떤것인지 알고 로딩팝업등 체크하여 제거 및
/// 현재 화면에 맞는 데이터 셋팅등을 위해서 사용하려고 했다
///
/// 스택은 로딩 팝업이 스택에 존재하는지 체크 후 로딩 삭제를 위해서
///
class BaseNavigatorObserver extends NavigatorObserver {
  final List<Route> routeStack = [];

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    int oldStack = routeStack.length;

    routeStack.add(route);

    printStack();

    QcLog.i("""[Push 정보 (route stack : $oldStack > ${routeStack.length})]
        이전 라우트: ${previousRoute?.settings.name}
        >> [현재 라우트: ${route.settings.name}]""");
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    int oldStack = routeStack.length;

    routeStack.remove(route);

    printStack();

    QcLog.i("""[Pop 정보 (route stack : $oldStack > ${routeStack.length})]
        현재 라우트: ${route.settings.name} 제거
        >>> [이전 라우트: ${previousRoute?.settings.name}] 노출 """);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    int oldStack = routeStack.length;

    routeStack.remove(route);
    printStack();

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
    }
    printStack();

    QcLog.i("""[Replace 정보 (route stack : $oldStack > ${routeStack.length})]
      이전 라우트: ${oldRoute?.settings.name}
        >>> [현재 라우트: ${newRoute?.settings.name}]""");
  }

  void dispose() {}

  void printStack() {
    print('┌─────────── Current Navigator stack ──────────────');
    // print("======= Current Navigator stack ======= ");
    for (var route in routeStack) {
      print('Route Name : ${route.settings.name}');
      print(
          '            isFirst: ${route.isFirst} /  isActive: ${route.isActive} /'
          ' isCurrent: ${route.isCurrent} /  overlayEntries: ${route.overlayEntries.length} /'
          'settings: ${route.settings.toString()} /'
          ' ');
    }
  }
}

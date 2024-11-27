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
/// 1. MainApp
///
///  NavigatorObserverNotifier navigatorObserver = NavigatorObserverNotifier();
///
/// widget에서
///  var myObserver = (context.findAncestorWidgetOfExactType<MyApp>() as MyApp).navigatorObserver;
///       myObserver.addListener((){
///         QcLog.d('myObserver ==== ${myObserver.currentRoute.toString()}');
///       });
///
/// 2. ChangeNotifierProvider
///  navigatorObserver = ref.watch(navigatorObserverNotifier);
///
class NavigatorObserverNotifier extends NavigatorObserver with ChangeNotifier {
  // final List<int> _values = <int>[];
  //
  // List<int> get values => _values.toList();
  //
  // void add(int value) {
  //   _values.add(value);
  //   notifyListeners();
  // }

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

    notifyListeners();
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
    notifyListeners();
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
    notifyListeners();
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
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    QcLog.d('dispose navigatorObserverNotifier =============');
  }

  void _printStack() {
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

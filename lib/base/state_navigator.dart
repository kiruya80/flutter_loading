import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_dialog/util/print_log.dart';

import 'base_state.dart';
import '../navigator/navigator_observer_notifier.dart';

///
/// 생성일 : 2024. 11. 14.
/// class 설명
///
///
abstract class StateNavigator<T extends ConsumerStatefulWidget> extends BaseState<T> {
  NavigatorObserverNotifier? navigatorObserver;

  List<Route> routeStack = [];
  Route? currentRoute;
  String tempRouteList = '';

  setNavigatorObserver() {
    navigatorObserver = ref.watch(navigatorObserverNotifier);
    QcLog.d(
        '[$routeName] currentRoute === ${navigatorObserver?.currentRoute?.settings.name} // ${navigatorObserver?.currentRoute}');
    print('[$routeName] routeStack length =========  ${navigatorObserver?.routeStack.length}');
    tempRouteList = '';
    for (var item in navigatorObserver!.routeStack) {
      print('[$routeName] routeStack ===  ${item.toString()}');
      tempRouteList += item.settings.toString() + '\n';
    }

    setState(() {
      currentRoute = navigatorObserver?.currentRoute;
      routeStack = navigatorObserver?.routeStack ?? [];
    });
  }

  /**
      - build
      - initState
      - dispose
      - didUpdateWidget
      - didChangeDependencies
   */
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      routeName = ModalRoute.of(context)?.settings.name;
      setNavigatorObserver();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('[$routeName] BaseState === didChangeDependencies === ${context.mounted} ');
  }

  @override
  void didUpdateWidget(covariant T oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('[$routeName] BaseState === didUpdateWidget === ${context.mounted} ');
  }

  ///
  /// route 종료시 pop
  /// deactivate > dispose
  /// context.mounted > true
  ///
  @override
  void deactivate() {
    super.deactivate();
    print('[$routeName] BaseState === deactivate === ${context.mounted} ');
  }

  /// context.mounted > false
  @override
  void dispose() {
    print('[$routeName] BaseState === dispose ===  ${context.mounted} ');
    WidgetsBinding.instance.removeObserver(this);
    // if (isListenGlobalEvent) {
    //   unregisterGlobalEvent();
    // }
    navigatorObserver?.dispose();
    super.dispose();
  }
}

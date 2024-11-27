import 'package:flutter/cupertino.dart';
import 'package:loading_dialog/util/print_log.dart';

import '../base_state.dart';
import '../../navigator/riverpod/navigator_observer_notifier.dart';

///
/// 생성일 : 2024. 11. 14.
/// class 설명
///
/// 라우터가 현재 보이는 라우터인지 체크를 위해서 - 이때만 업데이트등
/// 라우터 스택에 특정 라우터가 있는지 체크 (로딩등 체크 후 제거를 위해서)
///
abstract class StateNavigator<T extends StatefulWidget> extends BaseState<T> {
  NavigatorObserverNotifier? navigatorObserver;

  List<Route> routeStack = [];
  Route? currentRoute;
  String tempRouteList = '';
  bool _isPushed = false;

  setNavigatorObserver() {
    QcLog.d(
        '[$routeName] myObserver ==== currentRoute : ${navigatorObserver?.currentRoute?.settings.name} , '
        'isActive : ${navigatorObserver?.currentRoute?.isActive} ,'
        'isCurrent : ${navigatorObserver?.currentRoute?.isCurrent} , '
        'isFirst : ${navigatorObserver?.currentRoute?.isFirst} , '
        '${navigatorObserver?.currentRoute.toString()}');
    print(
        '[$routeName] routeStack length =========  ${navigatorObserver?.routeStack.length}');

    tempRouteList = '';

    if (navigatorObserver?.routeStack.isNotEmpty == true) {
      for (var item in navigatorObserver!.routeStack) {
        print('[$routeName] routeStack ===  ${item.toString()}');
        tempRouteList += item.settings.toString() + '\n';
      }
    }

    setState(() {
      currentRoute = navigatorObserver?.currentRoute;
      routeStack = navigatorObserver?.routeStack ?? [];
    });
  }

  /// route?.isCurrent == true 백으로 동라오는 경우 가능
  /// route?.isCurrent == false 최초는 이렇게 되는데
  ///
  _navigatorListener() {
    if (route?.isCurrent == false) {
      return;
    }
    QcLog.d(
        '[$routeName] initState @@@@@@@@@@@@ _navigatorListener ${context.mounted} , '
        'isActive : ${route?.isActive} ,'
        'isCurrent : ${route?.isCurrent} , '
        'isFirst : ${route?.isFirst} ,  ');
    if (navigatorObserver?.currentRoute?.settings.name ==
            route?.settings.name &&
        route?.isActive == true &&
        route?.isCurrent == true) {}
    setNavigatorObserver();
  }

  ///
  /// app 에서 navigatorObserver 가져오기
  @override
  void initState() {
    super.initState();
    QcLog.d('[$routeName] initState @@@@@@@@@@@@');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      QcLog.d('[$routeName] initState @@@@@@@@@@@@ addPostFrameCallback ');
      routeName = ModalRoute.of(context)?.settings.name;

      // 1.
      // navigatorObserver =
      //     (context.findAncestorWidgetOfExactType<MyApp>() as MyApp)
      //         .navigatorObserver;
      // navigatorObserver?.addListener(_navigatorListener);

      var result = Navigator.of(context).widget.observers.firstWhere(
            (observer) => observer is NavigatorObserverNotifier,
            // orElse: () => null, // Observer가 없을 경우 null 반환
          );
      QcLog.d('observers ===== ${result} / ${result.toString()}');

      navigatorObserver?.addListener(() {
        QcLog.d('[$routeName] initState @@@@@@@@@@@@ addListener ');
        QcLog.d(
            '[$routeName] myObserver ==== ${navigatorObserver?.currentRoute.toString()}');
        setNavigatorObserver();
      });
      // 2. navigatorObserver = ref.watch(navigatorObserverNotifier);
      // setNavigatorObserver();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(
        '[$routeName] BaseState === didChangeDependencies === ${context.mounted} ');

    WidgetsBinding.instance.addPostFrameCallback((_) {
      QcLog.d(
          '[$routeName] didChangeDependencies @@@@@@@@@@@@ mounted ${context.mounted} , '
          'isActive : ${route?.isActive} ,'
          'isCurrent : ${route?.isCurrent} , '
          'isFirst : ${route?.isFirst} ,  ');
      if (!_isPushed && ModalRoute.of(context)?.isCurrent == true) {
        _isPushed = true;
        print('[$routeName] was pushed!');
      }
    });

    // final route = ModalRoute.of(context);
    // if (route != null && route.isCurrent) {
    //   print('This widget was pushed onto the stack');
    // }
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
  /// StatefulWidget이 더 이상 활성 상태가 아니게 되면, deactivate() 메서드가 호출됩니다.
  /// 이 메서드는 위젯이 화면에서 제거되기 전에 호출되며, 필요한 정리 작업을 수행하는데 사용됩니다.
  @override
  void deactivate() {
    super.deactivate();
  }

  /// context.mounted > false
  @override
  void dispose() {
    navigatorObserver?.removeListener(_navigatorListener);
    // if (isListenGlobalEvent) {
    //   unregisterGlobalEvent();
    // }
    // navigatorObserver?.dispose();
    super.dispose();
  }
}

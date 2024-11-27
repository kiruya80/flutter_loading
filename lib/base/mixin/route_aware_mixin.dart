import 'package:flutter/cupertino.dart';
import 'package:loading_dialog/util/print_log.dart';

import '../../main.dart';

///
///  todo RouteAware 무엇을 위해서?
///  화면 이동시 또는 화면 돌아오는 경우등에 데이터나 설정등이 필요할때 사용
///
///
///
/// mixin은 특정 기능등을 추가해주기 위해서 사용함
/// 재사용, 다중 적용,
///
/// todo RouteAware로 사용하기는 알맞지 않은듯
/// 왜? didChangeDependencies에서 옵져버 구독과정이 등러가야해서
/// 사요한다면 많은 화면이 아니라, 특정 화면에서만 필요할때 정도?
///
///  class _FourthPageState extends BaseState<FourthPage> with RouteAwareMixin{
/// with RouteAwareMixin {
///
mixin RouteAwareMixin<T extends StatefulWidget> on State<T>
    implements RouteAware {
  RouteObserver? _observer;

  /// 최상위 경로가 팝오프되고 현재 경로가
  /// 표시될 때 호출됩니다.
  /// 돌아올때
  @override
  void didPopNext() {
    QcLog.e(
        'StateRouteAware ======= didPopNext ====  ${ModalRoute.of(context)?.settings.name}');
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).unfocus();
  }

  /// 현재 경로가 푸시될 때 호출됩니다.
  @override
  void didPush() {
    QcLog.e(
        'StateRouteAware ======= didPush ====  ${ModalRoute.of(context)?.settings.name}');
  }

  /// 새 경로가 푸시되고 현재 경로가
  /// 더 이상 표시되지 않을 때 호출됩니다.
  @override
  void didPushNext() {
    QcLog.e(
        'StateRouteAware ======= didPushNext ====  ${ModalRoute.of(context)?.settings.name}');
    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(context).unfocus();
  }

  /// 현재 경로가 팝오프될 때 호출됩니다.
  @override
  void didPop() {
    QcLog.e(
        'StateRouteAware ======= didPop ====  ${ModalRoute.of(context)?.settings.name}');

    // LoadingDialog().hide(closeContext: context);
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   _observer = context.findAncestorWidgetOfExactType<MyApp>()?.myObserver;
  //   // _observer =  RouterScope.of(context).firstObserverOfType<AutoRouteObserver>();
  //   if (_observer != null) {
  //     _observer!.subscribe(this, ModalRoute.of(context) as Route);
  //   }
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print(
        ' [${ModalRoute.of(context)?.settings.name}] RouteAwareMixin === didChangeDependencies ==='
        ' ${context.mounted} ');

    getObserver();
  }

  getObserver() {
    if (_observer != null) {
      return;
    }

    _observer = getNavigatorObserver(context);

    if (_observer != null) {
      QcLog.d('Found NavigatorObserver: ${_observer.runtimeType}');
      // we subscribe to the observer by passing our
      // AppRouteAware state and the scoped routeData
      _observer?.subscribe(this, ModalRoute.of(context) as Route);
    } else {
      QcLog.d('No NavigatorObserver found.');
      // RouterScope exposes the list of provided observers
      // including inherited observers
      // get navigatorObservers
      _observer = context.findAncestorWidgetOfExactType<MyApp>()?.routeObserver
          as RouteObserver;
      // _observer =  RouterScope.of(context).firstObserverOfType<AutoRouteObserver>();
      if (_observer != null) {
        // we subscribe to the observer by passing our
        // AppRouteAware state and the scoped routeData
        _observer?.subscribe(this, ModalRoute.of(context) as Route);
      }
    }
  }

  RouteObserver? getNavigatorObserver(BuildContext context) {
    RouteObserver? routeObserver;
    if (Navigator.of(context).widget.observers.isNotEmpty) {
      for (var item in Navigator.of(context).widget.observers) {
        if (item is RouteObserver) {
          routeObserver = item;
        }
        QcLog.d('observers ==== ${item.toString()}');
      }
    }
    return routeObserver;
  }

  @override
  void dispose() {
    super.dispose();
    _observer?.unsubscribe(this);
  }
}

// class AutoRouteObserver extends MyNavigatorObserver {
//   class AutoRouteObserver extends NavigatorObserver {
//   final Map<LocalKey, Set<RouteAware>> _listeners = <LocalKey, Set<RouteAware>>{};
//   void subscribe(RouteAware routeAware, R route) {
//     final Set<RouteAware> subscribers = _listeners.putIfAbsent(route, () => <RouteAware>{});
//     if (subscribers.add(routeAware)) {
//       routeAware.didPush();
//     }
//   }
//   void subscribe(RouteAware routeAware, RouteData route) {
//     final Set<RouteAware> subscribers =
//     _listeners.putIfAbsent(route.key, () => <RouteAware>{});
//     if (subscribers.add(routeAware)) {
//       // if (route.router is TabsRouter) {
//       //   routeAware.didInitTabRoute(null);
//       // } else {
//         routeAware.didPush();
//       // }
//     }
//   }
//
//   void unsubscribe(RouteAware routeAware) {
//     for (final route in _listeners.keys) {
//       final Set<RouteAware>? subscribers = _listeners[route];
//       subscribers?.remove(routeAware);
//     }
//   }
//   /// subscribed to multiple types, this will unregister it (once) from each type.
//   void unsubscribe(RouteAware routeAware) {
//     final List<R> routes = _listeners.keys.toList();
//     for (final R route in routes) {
//       final Set<RouteAware>? subscribers = _listeners[route];
//       if (subscribers != null) {
//         subscribers.remove(routeAware);
//         if (subscribers.isEmpty) {
//           _listeners.remove(route);
//         }
//       }
//     }
//   }
//   @override
//   void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     // if (route.settings is AutoRoutePage &&
//     //     previousRoute?.settings is AutoRoutePage) {
//       // final previousKey = (previousRoute!.settings as AutoRoutePage).routeKey;
//       final previousKey = (previousRoute!.settings).hashCode.toString();
//       final List<RouteAware>? previousSubscribers =
//       _listeners[previousKey]?.toList();
//
//       if (previousSubscribers != null) {
//         for (final RouteAware routeAware in previousSubscribers) {
//           routeAware.didPopNext();
//         }
//       }
//       // final key = (route.settings as AutoRoutePage).routeKey;
//       final key = route.settings. .routeKey;
//
//       final List<RouteAware>? subscribers = _listeners[key]?.toList();
//
//       if (subscribers != null) {
//         for (final RouteAware routeAware in subscribers) {
//           routeAware.didPop();
//         }
//       }
//     // }
//   }
//
//   @override
//   void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     // if (route.settings is AutoRoutePage &&
//     //     previousRoute?.settings is AutoRoutePage) {
//       final previousKey = (previousRoute!.settings ).routeKey;
//       final Set<RouteAware>? previousSubscribers = _listeners[previousKey];
//
//       if (previousSubscribers != null) {
//         for (final RouteAware routeAware in previousSubscribers) {
//           routeAware.didPushNext();
//         }
//       }
//     // }
//   }
// }
//
// class NavigatorRouteObserver extends RouteObserver<Route> {
//
//   @override
//   void didPush(Route route, Route? previousRoute) {
//     super.didPush(route, previousRoute);
//
//   }
//
//   @override
//   void didPop(Route route, Route? previousRoute) {
//     super.didPop(route, previousRoute);
//   }
//
//   @override
//   void didRemove(Route route, Route? previousRoute) {
//     super.didRemove(route, previousRoute);
//   }
//
//   @override
//   void didReplace({Route? newRoute, Route? oldRoute}) {
//     super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
//   }
//
//   @override
//   void unsubscribe(RouteAware routeAware) {
//
//   }
//
//   @override
//   void subscribe(RouteAware routeAware, Route route) {
//
//   }
//
//
// }

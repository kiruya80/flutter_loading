import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../navigator/my_navigator_observer.dart';
import '../provider/route_aware_notifier.dart';
import '../util/print_log.dart';
import 'base_state.dart';

///
/// 생성일 : 2024. 11. 14.
/// class 설명
///
///
abstract class StateRoute<T extends ConsumerStatefulWidget> extends BaseState<T> with RouteAware {
  // MyNavigatorObserver? myObserver;
  // RouteObserver<PageRoute>? routeObserver;
  // RouteAwareNotifier? routeAwareNotifier;

  @override
  void initState() {
    super.initState();
    // print('BaseState === initState === ');
    // routeAwareNotifier = ref.read(routeAwareProvider.notifier);
    // setNavigatorObserver();
  }

  @override
  void deactivate() {
    super.deactivate();
    print('BaseState === deactivate === ');
  }

  @override
  void dispose() {
    super.dispose();
    print('BaseState === dispose === ');
    // final routeAwareNotifier = ref.read(routeAwareProvider.notifier);
    // routeAwareNotifier.unsubscribe();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('BaseState === didChangeDependencies === ');

    // final routeAwareNotifier = ref.read(routeAwareProvider.notifier);
    // routeAwareNotifier.subscribe(ModalRoute.of(context));

    // routeObserver = (context.findAncestorWidgetOfExactType<MyApp>() as MyApp).routeObserver;
    //
    // var route = ModalRoute.of(context);
    // if (route != null) {
    //   routeObserver?.subscribe(this, route);
    // }
  }

  @override
  void didPush() {
    print("BaseState === Page pushed: ");
  }

  @override
  void didPopNext() {
    //${ModalRoute.of(context)?.settings.name}
    print("BaseState === Returned to this page: ");
  }

  @override
  Future<bool> didPopRoute() {
    print('BaseState === didPopRoute === ');
    return super.didPopRoute();
  }

  @override
  bool handleStartBackGesture(PredictiveBackEvent backEvent) {
    print('BaseState === handleStartBackGesture === ${backEvent.toString()}');
    return super.handleStartBackGesture(backEvent);
  }

  @override
  void handleCancelBackGesture() {
    print('BaseState === handleCancelBackGesture === ');
    super.handleCancelBackGesture();
  }

  @override
  void handleCommitBackGesture() {
    print('BaseState === handleCommitBackGesture === ');
    super.handleCommitBackGesture();
  }

// setNavigatorObserver() {
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
// }
}

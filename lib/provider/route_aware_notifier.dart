// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:loading_dialog/provider/route_observer_provider.dart';
//
// ///
// /// 생성일 : 2024. 11. 14.
// /// class 설명
// ///
// ///
// ///
// final routeAwareProvider = StateNotifierProvider<RouteAwareNotifier, String?>((ref) {
//   final routeObserver = ref.watch(routeObserverProvider);
//   return RouteAwareNotifier(routeObserver);
// });
//
// class RouteAwareNotifier extends StateNotifier<String?> with RouteAware {
//   final RouteObserver<PageRoute> routeObserver;
//
//   RouteAwareNotifier(this.routeObserver) : super(null);
//
//   void subscribe(Route<dynamic>? route) {
//     routeObserver.subscribe(this, route as PageRoute);
//   }
//
//   void unsubscribe() {
//     routeObserver.unsubscribe(this);
//   }
//
//   @override
//   void didPush() {
//     state = "Route Pushed";
//     print("Route pushed: ${state}");
//   }
//
//   @override
//   void didPopNext() {
//     state = "Route Popped Next";
//     print("Returned to this page: ${state}");
//   }
// }

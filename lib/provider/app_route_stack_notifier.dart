import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_route_stack_notifier.g.dart';

///
/// 생성일 : 2024. 11. 15.
/// class 설명
///
///
@riverpod
class AppRouteStackNotifier extends _$AppRouteStackNotifier {
  // @override
  // bool build() {
  //   return false;
  // }
  //
  // update(bool newState) {
  //   state = newState;
  // }
  @override
  List<Route>? build() {
    return null;
  }

  update(List<Route> routeStack) {
    state = routeStack;
  }

  ///
  /// 로딩 라우터가 있는지 체크
  ///
  bool isLoadingRoute(String dialogRouteName) {
    if (state?.isEmpty == true) {
      return false;
    }

    for (Route data in state!) {
      if (data.settings.name == dialogRouteName) {
        return true;
      }
    }
    return false;
  }
}

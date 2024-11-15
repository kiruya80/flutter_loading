import 'package:flutter/cupertino.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_current_route_notifier.g.dart';

///
/// 생성일 : 2024. 11. 15.
/// class 설명
///
///
@riverpod
class AppCurrentRouteNotifier extends _$AppCurrentRouteNotifier {
  @override
  Route? build() {
    return null;
  }

  /// current route update
  update(Route route) {
    state = route;
  }
}

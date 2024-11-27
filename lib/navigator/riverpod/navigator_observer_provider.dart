import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_dialog/util/print_log.dart';

import 'navigator_observer_notifier.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
///
/// route 옵져버
///
/// 참고
/// https://medium.com/@atefelsaid3/mastering-navigation-tracking-in-flutter-a-complete-guide-to-routeobserver-with-riverpod-ea23a12fb80c
///
///
///

final navigatorObserverNotifier =
    ChangeNotifierProvider.autoDispose<NavigatorObserverNotifier>((ref) {
  QcLog.e('NavigatorObserverNotifier Provider === ');

  return NavigatorObserverNotifier();
});

// final myNavigatorObserverProvider = Provider<NavigatorObserver>((ref) {
//   QcLog.e('myNavigatorObserverProvider Provider === ');
//   return MyNavigatorObserver();
// });

import 'package:flutter/widgets.dart';

import '../../util/print_log.dart';
import '../../util/shared_prefs_helper.dart';

mixin BaseMixin on WidgetsBindingObserver {
  SharedPrefsHelper sharedPrefsHelper = getSharedPrefsHelper();
  Route? route;
  String? routeName;

  void readyWidget();

  ///
  /// 앱에서 홈
  /// inactive > hidden > paused
  ///
  /// 홈에서 앱
  /// hidden > inactive > resumed
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    QcLog.d('didChangeAppLifecycleState === ${state.name}');
    switch (state) {
      case AppLifecycleState.resumed:
        QcLog.d('${state.name} // App is in foreground == ');
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.paused:
        QcLog.d('${state.name} // App is in background == ');
        break;
    }
  }
}
mixin BaseMixin2<T extends StatefulWidget> on State<T> {
  // SharedPrefsHelper sharedPrefsHelper = getSharedPrefsHelper();
  // Route? route;
  // String? routeName;
  //
  // void readyWidget();
}

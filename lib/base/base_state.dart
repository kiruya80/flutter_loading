import 'dart:async';
import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_dialog/util/print_log.dart';

import '../loading_dialog.dart';
import '../util/shared_prefs_helper.dart';

///
/// 생성일 : 2024. 11. 14.
/// class 설명
///
///
abstract class BaseState<T extends ConsumerStatefulWidget> extends ConsumerState<T>
    with WidgetsBindingObserver {
  SharedPrefsHelper sharedPrefsHelper = getSharedPrefsHelper();
  String? routeName;

  void readyWidget();

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
    QcLog.d('[$routeName] initState === ${context.mounted} ');

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      routeName = ModalRoute.of(context)?.settings.name;
      QcLog.d('[$routeName] initState === addPostFrameCallback / readyWidget ');
      // setNavigatorObserver();
      readyWidget();
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
    super.dispose();
  }

  Future<void> showLoading({bool isCanPop = false, bool? isDelay}) async {
    LoadingDialog().show(context, isCanPop: isCanPop);
    if (isDelay == true) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  void hideLoading() {
    print('[$routeName] BaseState === hideLoading ===  ${context.mounted} ');
    LoadingDialog().hide(closeContext: context);
  }

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

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../loading_dialog.dart';
import '../util/print_log.dart';
import 'mixin/base_mixin.dart';

abstract class BaseConsumerState<T extends ConsumerStatefulWidget>
    extends ConsumerState<T> with WidgetsBindingObserver, BaseMixin {
  @override
  void initState() {
    super.initState();
    QcLog.d('[$routeName] initState === ${context.mounted}');

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      route = ModalRoute.of(context);
      routeName = ModalRoute.of(context)?.settings.name;
      QcLog.d('[$routeName] initState === addPostFrameCallback / readyWidget ');
      // setNavigatorObserver();
      readyWidget();
    });
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   print(
  //       '[$routeName] BaseState === didChangeDependencies === ${context.mounted} ');
  // }

  // @override
  // void didUpdateWidget(covariant T oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   print('[$routeName] BaseState === didUpdateWidget === ${context.mounted} ');
  // }

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
    LoadingDialog().show(context, isCanPop: isCanPop, isDelay: isDelay);
  }

  void hideLoading() {
    LoadingDialog().hide(closeContext: context);
  }
}

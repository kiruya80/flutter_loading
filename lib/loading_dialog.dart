import 'package:flutter/material.dart';
import 'package:loading_dialog/util/print_log.dart';

class LoadingDialog {
  static const String LoadingDialogRouteName = "LoadingDialog";
  static final LoadingDialog _instance = LoadingDialog._internal();

  BuildContext? context;

  factory LoadingDialog() {
    return _instance;
  }

  /// Take users Context and saves to avariable
  // LoadingDialog init() {
  //   return _instance;
  // }

  LoadingDialog._internal();

  void show(BuildContext context, {bool isCanPop = false}) {
    loadingDialog(context, isCanPop: isCanPop);
  }

  /// BuildContext 를 비교해서 다이얼로그를 사용했던 BuildContext만 닫기 가능하게?
  ///
  void hide({BuildContext? closeContext}) {
    QcLog.i('LoadingOverlay hide === ');
    QcLog.i('context widget name === ${context?.mounted} , ${context?.widget.toString()}');
    QcLog.i(
        'closeContext widget name === ${closeContext?.mounted} , ${closeContext?.widget.toString()}');

    if (context != null && context?.mounted == true) {
      final currentRoute = ModalRoute.of(context!);
      QcLog.i('Current Route: ${currentRoute?.settings.name} , ${currentRoute.toString()}');

      Navigator.pop(context!);
      // context = null;
    }
  }

  void clear() {
    QcLog.i('clear : ${context?.mounted} , ${context.toString()} , ${context?.widget.toString()}');
    // 현재 라우터 정보 가져오기
    if (context != null && context?.mounted == true) {
      final currentRoute = ModalRoute.of(context!);
      QcLog.i('Current Route: ${currentRoute?.settings.name} , ${currentRoute.toString()}');

      Navigator.pop(context!);
      context = null;
    }
  }

  ///
  /// 라우터 사용으로 다음 화면 이동시 사라짐 - 연속성 필요한가??
  ///
  /// 제거방법 - 라우터에서 다이얼로그 라우터만 삭제 가능하게
  ///
  Future<bool?> loadingDialog(BuildContext context, {bool isCanPop = false}) async {
    this.context = context;
    QcLog.i('context === ${context.toString()}');
    QcLog.i('context mounted === ${context.mounted}');
    QcLog.i('context widget name === ${context.widget.toString()}');

    return await showDialog<bool>(
        context: context,
        routeSettings: const RouteSettings(name: LoadingDialogRouteName),
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog.fullscreen(
              backgroundColor: Colors.transparent,
              child: PopScope(
                canPop: isCanPop,
                onPopInvokedWithResult: (bool didPop, Object? result) {
                  /// canPop 이 true 인 경우,
                  /// 백키로 닫는 경우 > onPopInvokedWithResult (true) true , null
                  /// hide 호출로 닫는 경우 > onPopInvokedWithResult (true) true , null
                  QcLog.e(
                      'onPopInvokedWithResult fullscreen ==== ($isCanPop) $didPop , ${result.toString()}');
                  if (didPop) {
                    return;
                  }
                  // final NavigatorState navigator = Navigator.of(context);
                  // final bool? shouldPop = await _showConfirmDialog("Unsaved settings. Discard?");
                  // if (shouldPop ?? false) {
                  // navigator.pop();
                  // }

                  // 필요한가 ?
                  if (isCanPop == true) {
                    QcLog.e(
                        'onPopInvokedWithResult isCanPop == true ==== ($isCanPop) $didPop , ${result.toString()}');
                    hide();
                  }
                },
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(
                        height: 50,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Navigator.pop(context);
                          hide();
                        },
                        child: Text("${isCanPop ? "백키 가능" : "백키 불가"} , 닫기"),
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  showLoadingRoute(BuildContext context, {bool isCanPop = false}) {
    this.context = context;
    Navigator.of(context, rootNavigator: true).push(_loadDialogRoute(context, isCanPop: isCanPop));
  }

  _loadDialogRoute(BuildContext context, {bool isCanPop = false}) {
    return DialogRoute(
      context: context,
      settings: const RouteSettings(name: LoadingDialogRouteName),
      barrierDismissible: false,
      // 바깥을 눌러도 다이얼로그가 닫히지 않음
      barrierColor: Colors.black.withOpacity(0.5),
      // 반투명한 배경
      builder: (context) => PopScope(
        canPop: isCanPop,
        onPopInvokedWithResult: (bool didPop, Object? result) {
          print(
              'onPopInvokedWithResult DialogRoute ==== ($isCanPop) $didPop , ${result.toString()}');
          if (didPop) {
            return;
          }
          // final NavigatorState navigator = Navigator.of(context);
          // final bool? shouldPop = await _showConfirmDialog("Unsaved settings. Discard?");
          // if (shouldPop ?? false) {
          // navigator.pop();
          // }

          // 필요한가 ?
          if (isCanPop == true) {
            hide();
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context);
                  hide();
                },
                child: Text("${isCanPop ? "백키 가능" : "백키 불가"} , 닫기"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:loading_dialog/page/loading_dialog_page.dart';
import 'package:loading_dialog/util/print_log.dart';

/// 다이얼로그를
/// 1. showDialog 로 호출
/// 2. DialogRoute 로 호출
///
class LoadingDialog {
  static const String LoadingDialogRouteName = "LoadingDialog";
  static final LoadingDialog _instance = LoadingDialog._internal();

  BuildContext? context;
  bool? isCanPop = false;

  factory LoadingDialog() {
    return _instance;
  }

  LoadingDialog._internal();

  void show(BuildContext context, {bool isCanPop = false}) {
    if (this.context != null &&
        this.context?.mounted == true &&
        this.context?.widget == context.widget) {
      QcLog.d('Dialog show ====');
      return;
    }

    _loadingDialog(context, isCanPop: isCanPop);
  }

  /// BuildContext 를 비교해서 다이얼로그를 사용했던 BuildContext만 닫기 가능하게?
  ///
  void hide({BuildContext? closeContext}) {
    QcLog.i('LoadingOverlay hide === ${context?.mounted} ,'
        ' ${context?.widget.toString()}, ${closeContext?.widget.toString()}');

    if (context != null && context?.mounted == true && context?.widget == closeContext?.widget) {
      QcLog.i(
          'closeContext widget === ${closeContext?.mounted} , ${closeContext?.widget.toString()}');
      final currentRoute = ModalRoute.of(context!);
      QcLog.i('Current Route: ${currentRoute?.settings.name} , ${currentRoute.toString()}');

      Navigator.pop(context!);
      context = null;
    }
  }

  /// clear가 필요한가 ?
  /// 현재 라우터 스택에 로딩이 있는 경우 pop으로?
  ///
  void clear({BuildContext? closeContext}) {
    QcLog.i('clear : ${context?.mounted} , ${context.toString()} , ${context?.widget.toString()}'
        ', ');

    QcLog.i('closeContext : ${closeContext?.mounted} , ${closeContext?.widget.toString()}');
    // 현재 라우터 정보 가져오기
    if (context != null && context?.mounted == true) {
      final currentRoute = ModalRoute.of(context!);
      QcLog.i('Current Route: ${currentRoute?.settings.name} , ${currentRoute.toString()}');

      // Navigator.pop(context!);
      var route = MaterialPageRoute(builder: (context) => LoadingDialogPage());
      QcLog.i('route: ${route?.settings.name} , ${route.toString()}');

      Navigator.of(context!).removeRoute(
          // ModalRoute.of(context!)!.previous!,
          route);
    }
    context = null;
  }

  ///
  /// 라우터 사용으로 다음 화면 이동시 사라짐 - 연속성 필요한가??
  ///
  /// 제거방법 - 라우터에서 다이얼로그 라우터만 삭제 가능하게
  ///
  /// return Future.value(true);
  ///
  _loadingDialog(BuildContext context, {bool isCanPop = false}) async {
    this.context = context;
    this.isCanPop = isCanPop;
    QcLog.i('context === ${context.toString()}');
    QcLog.i('context mounted === ${context.mounted}');
    QcLog.i('context widget name === ${context.widget.toString()}');

    return showDialog(
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
                  /// 백키로 닫는 경우 > onPopInvokedWithResult didPop : true , result : null , isCanPop : true
                  /// hide 호출로 닫는 경우 > onPopInvokedWithResult didPop : true , result : null , isCanPop : false(isCanPop : true)
                  QcLog.e(
                      'onPopInvokedWithResult fullscreen ==== didPop : $didPop , result : ${result.toString()} , isCanPop : $isCanPop');
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
                    hide(closeContext: this.context);
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
                          hide(closeContext: this.context);
                        },
                        child: Text("${isCanPop ? "백키 가능" : "백키 불가"} , 닫기"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("clear"),
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  /// 다이얼로그를 DialogRoute 로 호출하는 방법
  showLoadingRoute(BuildContext context, {bool isCanPop = false}) {
    Navigator.of(context, rootNavigator: true).push(_loadDialogRoute(context, isCanPop: isCanPop));
  }

  _loadDialogRoute(BuildContext context, {bool isCanPop = false}) {
    this.context = context;
    this.isCanPop = isCanPop;
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
          QcLog.e(
              'onPopInvokedWithResult DialogRoute ==== didPop : $didPop , result : ${result.toString()} , isCanPop : $isCanPop');
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
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("clear"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

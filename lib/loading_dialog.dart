import 'package:flutter/material.dart';
import 'package:loading_dialog/page/flutter/loading_dialog_page.dart';
import 'package:loading_dialog/util/print_log.dart';

import 'base/route/route_state.dart';

/// 다이얼로그를
/// 1. showDialog 로 호출
/// 2. DialogRoute 로 호출
///
class LoadingDialog {
  static const String LoadingDialogRouteName = "/QcLoadingDialog";
  static final LoadingDialog _instance = LoadingDialog._internal();

  BuildContext? context;
  bool? isCanPop = false;

  factory LoadingDialog() {
    return _instance;
  }

  LoadingDialog._internal();

  ///
  /// 현재 라우터가 다이얼로그 라우터인지 체크
  ///
  Future<void> show(BuildContext showContext,
      {bool isCanPop = false, bool? isDelay}) async {
    if (this.context != null &&
        this.context?.mounted == true &&
        this.context?.widget == showContext.widget) {
      QcLog.d('Dialog show ==== ${this.context?.mounted}');
      print('this.context != null ==== ${this.context != null}');
      print(
          'this.context?.mounted == true ==== ${this.context?.mounted == true}');
      print(
          'this.context?.widget == showContext.widget ==== ${this.context?.widget == showContext.widget}');
      return;
    }

    FocusManager.instance.primaryFocus?.unfocus();
    FocusScope.of(showContext).unfocus();
    _loadingDialog(showContext, isCanPop: isCanPop);

    if (isDelay == true) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  /// BuildContext 를 비교해서 다이얼로그를 사용했던 BuildContext만 닫기 가능하게?
  ///
  void hide({BuildContext? closeContext, bool? isPop = true}) {
    // QcLog.i(' hide === ${context?.mounted} ,'
    //     ' ${context?.widget.toString()}, ${closeContext?.widget.toString()}');
    print('this.context != null ==== ${this.context != null}');
    print(
        'this.context?.mounted == true ==== ${this.context?.mounted == true}');
    print(
        'this.context?.widget == context.widget ==== ${this.context?.widget == closeContext?.widget}');

    if (context != null &&
        context?.mounted == true &&
        context?.widget == closeContext?.widget) {
      final currentRoute = ModalRoute.of(context!);
      QcLog.i(
          'Current Route: ${currentRoute?.settings.name} , ${currentRoute.toString()}');

      if (isPop == true) {
        Navigator.pop(context!);
      }
      FocusManager.instance.primaryFocus?.unfocus();
      // FocusScope.of(context!).unfocus();
      context = null;
    }
  }

  /// clear
  /// 로딩 > 화면이동 인 경우 이전 로딩이 있을 경우
  /// 로딩 닫기 가 가능한지
  ///
  void clear({BuildContext? closeContext}) {
    QcLog.i(
        'clear : ${context?.mounted} , ${context.toString()} , ${context?.widget.toString()}'
        ', ');

    QcLog.i(
        'closeContext : ${closeContext?.mounted} , ${closeContext?.widget.toString()}');
    // 현재 라우터 정보 가져오기
    if (context != null && context?.mounted == true) {
      final currentRoute = ModalRoute.of(context!);
      QcLog.i(
          'Current Route: ${currentRoute?.settings.name} , ${currentRoute.toString()}');

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

    /// 호출한 라우터 이름
    QcLog.i('context widget name === ${context.widget.toString()}');

    return showDialog(
        context: context,
        routeSettings: const RouteSettings(name: LoadingDialogRouteName),
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog.fullscreen(
              backgroundColor: Colors.transparent,
              // child: loadingWidget(isCanPop: isCanPop),
              child: LoadingWidget(
                  isCanPop: isCanPop,
                  onDialogClick: (isPop) {
                    QcLog.d('closeContext ===== $isPop');
                    hide(closeContext: this.context, isPop: isPop);
                  })
              // child: Loading(),
              );
        });
  }

  /// 다이얼로그를 DialogRoute 로 호출하는 방법
  showLoadingRoute(BuildContext context, {bool isCanPop = false}) {
    Navigator.of(context, rootNavigator: true)
        .push(_loadDialogRoute(context, isCanPop: isCanPop))
        .then((v) {
      QcLog.d('showLoadingRoute then ===== ${v.toString()}');
    });
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
        builder: (context) =>
            // loadingWidget(isCanPop: isCanPop)
            LoadingWidget(
                isCanPop: isCanPop,
                onDialogClick: (isPop) {
                  QcLog.d('closeContext ===== $isPop');
                  hide(closeContext: this.context, isPop: isPop);
                }));
  }

// loadingWidget({bool isCanPop = false}) {
//
//   return PopScope(
//     canPop: isCanPop,
//     onPopInvokedWithResult: (bool didPop, Object? result) {
//       QcLog.e(
//           'onPopInvokedWithResult DialogRoute ==== didPop : $didPop , result : ${result.toString()} , isCanPop : $isCanPop');
//       if (didPop) {
//         return;
//       }
//       // final NavigatorState navigator = Navigator.of(context);
//       // final bool? shouldPop = await _showConfirmDialog("Unsaved settings. Discard?");
//       // if (shouldPop ?? false) {
//       // navigator.pop();
//       // }
//
//       // 필요한가 ?
//       if (isCanPop == true) {
//         hide(closeContext: this.context);
//       }
//     },
//     child: Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const CircularProgressIndicator(),
//           const SizedBox(
//             height: 50,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Navigator.pop(context);
//               hide(closeContext: this.context);
//             },
//             child: Text("${isCanPop ? "백키 가능" : "백키 불가"} , 닫기"),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           ElevatedButton(
//             onPressed: () {
//               // Navigator.pop(context);
//               hide(closeContext: this.context);
//             },
//             child: Text("clear"),
//           )
//         ],
//       ),
//     ),
//   );
// }
}

class LoadingWidget extends StatefulWidget {
  final bool isCanPop;

  // VoidCallback? onDialogClick;
  final Function onDialogClick;

  const LoadingWidget({
    super.key,
    required this.isCanPop,
    required this.onDialogClick,
  });

  // const LoadingWidget(this.isCanPop, this.onDialogClick);

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends RouteState<LoadingWidget> {
  @override
  void readyWidget() {}

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.isCanPop,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        QcLog.e('onPopInvokedWithResult DialogRoute ==== didPop : $didPop ,'
            ' result : ${result.toString()} , isCanPop : ${widget.isCanPop}');
        if (didPop) {
          /// 백키로 닫기시 다이얼로그 처리
          widget.onDialogClick(false);
          return;
        }
        // final NavigatorState navigator = Navigator.of(context);
        // final bool? shouldPop = await _showConfirmDialog("Unsaved settings. Discard?");
        // if (shouldPop ?? false) {
        // navigator.pop();
        // }

        // 필요한가 ?
        if (widget.isCanPop == true) {
          widget.onDialogClick(true);
          // hide(closeContext: this.context);
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
                widget.onDialogClick(true);
              },
              child: Text("${widget.isCanPop ? "백키 가능" : "백키 불가"} , 닫기"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                widget.onDialogClick(true);
              },
              child: Text("clear"),
            )
          ],
        ),
      ),
    );
  }
}

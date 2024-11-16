///
/// 생성일 : 2024. 11. 8.
/// class 설명
///
///
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_dialog/util/print_log.dart';

///
///
/// WillPopScope와 ModalBarrier를 함께 사용하여 OverlayEntry에서 뒤로 가기 동작을 막을 수 있습니다. 이를 통해 오버레이가 열려 있는 동안 뒤로 가기 키가 눌려도 오버레이만 닫히도록 제어할 수 있습니다.
///
class LoadingOverlay {
  static final LoadingOverlay _instance = LoadingOverlay._internal();

  factory LoadingOverlay() => _instance;

  LoadingOverlay._internal();

  static OverlayEntry? _overlayEntry;

  static OverlayEntry? get overlayEntry => _overlayEntry;
  bool isCanPop = false;

  void showOverlay(BuildContext context, {bool isCanPop = false}) {
    if (isLoading() == true) {
      hide();
    }
    this.isCanPop = isCanPop;
    print('showOverlay ====== $isCanPop');

    _overlayEntry = OverlayEntry(
      builder: (context) => PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          QcLog.e(
              'onPopInvokedWithResult showOverlay ==== didPop : $didPop , result : ${result.toString()} , isCanPop : $isCanPop');

          if (isCanPop) {
            // SystemNavigator.pop();
            hide();
          }
          // if (didPop) {
          //   return;
          // }
          // final bool shouldPop = await _showDialog(context) ?? false;
          //
          // print('_showDialog === $shouldPop');
          // if (shouldPop) {
          //   // Since this is the root route, quit the app where possible by
          //   // invoking the SystemNavigator. If this wasn't the root route,
          //   // then Navigator.maybePop could be used instead.
          //   // See https://github.com/flutter/flutter/issues/11490
          //   SystemNavigator.pop();
          // }
        },
        child: Stack(
          children: [
            // 상호작용 차단을 위한 ModalBarrier
            ModalBarrier(
              dismissible: isCanPop, // 외부 탭으로 닫히지 않음
              color: Colors.black54,
            ),
            Center(
              child: Material(
                color: Colors.transparent,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        hide();
                      },
                      child: Text("Close Overlay"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );

    // final overlay = Overlay.of(context);
    Overlay.of(context).insert(_overlayEntry!);
  }

  // 로딩 다이얼로그 종료
  void hide() {
    print('LoadingOverlay hide === ');
    if (_overlayEntry != null && _overlayEntry?.mounted == true) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  bool isLoading() {
    if (_overlayEntry != null) return true;
    return false;
  }

// void removeOverlay() {
//   if (_overlayEntry != null && _overlayEntry?.mounted == true) {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }
// }

// static Future<bool?> _showDialog(BuildContext context) {
//   return showDialog<bool>(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         title: const Text('Are you sure?'),
//         content: const Text('Any unsaved changes will be lost!'),
//         actions: <Widget>[
//           TextButton(
//             child: const Text('Yes, discard my changes'),
//             onPressed: () {
//               Navigator.pop(context, true);
//             },
//           ),
//           TextButton(
//             child: const Text('No, continue editing'),
//             onPressed: () {
//               Navigator.pop(context, false);
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

// 로딩 다이얼로그 시작
// static void show(BuildContext context) {
//   if (_overlayEntry != null) return;
//   print('LoadingOverlay show === ');
//
//   _overlayEntry = OverlayEntry(
//     builder: (BuildContext context) => Material(
//       color: Colors.black38,
//       child: PopScope(
//         canPop: false,
//         onPopInvokedWithResult: (bool didPop, Object? result) {
//           print('onPopInvokedWithResult === $didPop');
//         },
//         child: const Center(
//           child: CircularProgressIndicator(),
//         ),
//       ),
//     ),
//   );
//
//   Overlay.of(context).insert(_overlayEntry!);
// }
}

class DismissibleOverlay extends StatelessWidget {
  final Widget child;
  final OverlayEntry? overlayEntry;

  const DismissibleOverlay({Key? key, required this.child, required this.overlayEntry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackButtonListener(
        onBackButtonPressed: () async {
          overlayEntry?.remove();
          return Future.value(true);
        },
        child: Dismissible(
            onDismissed: (dismissDirection) => overlayEntry?.remove(),
            direction: DismissDirection.vertical,
            key: Key(''),
            child: child));
  }
}

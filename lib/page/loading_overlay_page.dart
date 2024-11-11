import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../loading_overlay.dart';
import '../util/print_log.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
///
///
class LoadingOverlayPage extends StatefulWidget {
  @override
  State<LoadingOverlayPage> createState() => _LoadingOverlayPageState();
}

class _LoadingOverlayPageState extends State<LoadingOverlayPage> {
  bool isCanPop = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        QcLog.e('onPopInvokedWithResult fullscreen ====  $didPop , ${result.toString()} '
            '/ isCanPop: ${LoadingOverlay().isLoading()} , isLoading:  ${LoadingOverlay().isLoading()}');
        if (didPop) {
          return;
        }
        if (LoadingOverlay().isLoading()) {
          if (LoadingOverlay().isCanPop == true) {
            QcLog.e('로딩 닫기');
            // Navigator.pop(context); /// 화면만 뒤로 로딩은 유지된다
            LoadingOverlay().hide();

            /// 로딩 닫기
          }
        } else {
          /// 화면 이동
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("LoadingOverlayPage")),
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/ThirdPage');
              },
              child: Text("Navigator.pushNamed Third Page"),
            ),
            const SizedBox(
              height: 20,
            ),
            SwitchListTile(
              title: const Text("Back key"),
              value: isCanPop,
              onChanged: (bool value) {
                setState(() {
                  isCanPop = !isCanPop;
                });
              },
              secondary: const Icon(Icons.lightbulb_outline),
            ),
            const SizedBox(
              height: 50,
            ),

            ///
            ///
            ElevatedButton(
              onPressed: () async {
                LoadingOverlay().showOverlay(context, isCanPop: isCanPop);
              },
              child: Text("${isCanPop ? "백키 가능" : "백키 불가"} , 로딩"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                LoadingOverlay().showOverlay(context, isCanPop: isCanPop);
                await Future.delayed(const Duration(seconds: 5));
                Navigator.pushNamed(context, '/ThirdPage', arguments: isCanPop);

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => ThirdPage(
                //           isLoading: isMoveLoading,
                //         )));
              },
              child: Text("${isCanPop ? "백키 가능" : "백키 불가"} , 로딩 5초 후 ThirdPage 이동"),
            ),
          ]),
        ),
      ),
    );
  }
}

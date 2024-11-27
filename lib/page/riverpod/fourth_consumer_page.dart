import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../base/route/route_consumer_state.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
///
///
class FourthConsumerPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<FourthConsumerPage> createState() => _FourthConsumerPageState();
}

class _FourthConsumerPageState extends RouteConsumerState<FourthConsumerPage> {
  @override
  void readyWidget() {
    // TODO: implement readyWidget
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fourth Consumer Page")),
      body: Center(
        child: Column(
          children: [
            // Text(
            //     'route : ${currentRoute?.settings.name} [${routeStack.length}'
            // ),
            // Text(
            //     'tempRouteList : ${tempRouteList}'
            // ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                // 특정 라우트('/')를 제외한 모든 라우트 제거 후 HomePage로 돌아가기
                // context.router.popUntilRoot();
                Navigator.pushNamedAndRemoveUntil(
                    context, '/', (route) => false);

                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => FourthPage(),
                //         settings: RouteSettings(name: 'FourthPage'));
              },
              child: Text("Clear Stack and Go to Home Page"),
            ),
          ],
        ),
      ),
    );
  }
}

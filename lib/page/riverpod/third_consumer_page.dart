import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../base/route/route_consumer_state.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
///
///

class ThirdConsumerPage extends ConsumerStatefulWidget {
  final bool? isLoading;

  const ThirdConsumerPage({super.key, this.isLoading = false});

  @override
  ConsumerState<ThirdConsumerPage> createState() => _ThirdConsumerPageState();
}

///
///
///
class _ThirdConsumerPageState extends RouteConsumerState<ThirdConsumerPage> {
  @override
  void readyWidget() {
    // TODO: implement readyWidget
  }

  @override
  Widget build(BuildContext context) {
    print('build === ');
    return Scaffold(
      appBar: AppBar(title: Text("Third Consumer Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                Navigator.pushNamed(context, '/FourthConsumerPage');

                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => FourthPage(),
                //         settings: RouteSettings(name: '/FourthPage')));
              },
              child: Text("Go to Fourth Page"),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () async {
                showLoading();
              },
              child: Text("로딩 이미지 clear "),
            ),
            ElevatedButton(
              onPressed: () async {
                hideLoading();
                // LoadingDialog().clear(closeContext: context);
              },
              child: Text("로딩 이미지 clear "),
            ),
          ],
        ),
      ),
    );
  }
}

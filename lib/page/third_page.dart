import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base/base_state.dart';
import '../base/state_navigator.dart';
import '../loading_dialog.dart';
import '../util/print_log.dart';
import 'fourth_page.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
///
///

class ThirdPage extends ConsumerStatefulWidget {
  final bool? isLoading;

  const ThirdPage({super.key, this.isLoading = false});

  // const ThirdPage({super.key});

  @override
  ConsumerState<ThirdPage> createState() => _ThirdPageState();
}

///
///
///
class _ThirdPageState extends StateNavigator<ThirdPage> {


  @override
  void readyWidget() {
    // TODO: implement readyWidget
  }

  @override
  Widget build(BuildContext context) {
    print('build === ');
    return Scaffold(
      appBar: AppBar(title: Text("Third Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'route : ${currentRoute?.settings.name} [${routeStack.length}'
            ),
            Text(
                'tempRouteList : ${tempRouteList}'
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/FourthPage');

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

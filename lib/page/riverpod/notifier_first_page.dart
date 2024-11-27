import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../base/navigator/state_route_notifier.dart';
import '../../provider/app_current_route_notifier.dart';
import '../../provider/app_route_stack_notifier.dart';
import '../../util/print_log.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
///
///

class NotifierFirstPage extends ConsumerStatefulWidget {
  final bool? isLoading;

  const NotifierFirstPage({super.key, this.isLoading = false});

  @override
  ConsumerState<NotifierFirstPage> createState() => _NotifierFirstPageState();
}

///
///
///
class _NotifierFirstPageState extends StateRouteNotifier<NotifierFirstPage> {
  @override
  void readyWidget() {
    // TODO: implement readyWidget
  }

  @override
  Widget build(BuildContext context) {
    print('build === ');

    var appCurrentRouteNotifier = ref.watch(appCurrentRouteNotifierProvider);
    var appRouteStackNotifier = ref.watch(appRouteStackNotifierProvider);

    QcLog.d(
        'appCurrentRouteNotifier ==== ${appCurrentRouteNotifier?.settings.name}');
    QcLog.d('appRouteStackNotifier ==== ${appRouteStackNotifier?.length}');

    return Scaffold(
      appBar: AppBar(title: Text("Notifier Consumer First Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
                'route : ${currentRoute?.settings.name} [${routeStack.length}'),
            Text('tempRouteList : ${tempRouteList}'),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/NotifierSecondPage');

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

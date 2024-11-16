import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../base/state_navigator.dart';
import '../base/state_route_notifier.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
///
///

class NotifierSecondPage extends ConsumerStatefulWidget {
  final bool? isLoading;

  const NotifierSecondPage({super.key, this.isLoading = false});

  @override
  ConsumerState<NotifierSecondPage> createState() => _NotifierSecondPageState();
}

///
///
///
class _NotifierSecondPageState extends StateRouteNotifier<NotifierSecondPage> {
  @override
  void readyWidget() {
    // TODO: implement readyWidget
  }

  @override
  Widget build(BuildContext context) {
    print('build === ');
    return Scaffold(
      appBar: AppBar(title: Text("Notifier Second Page")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('route : ${currentRoute?.settings.name} [${routeStack.length}'),
            Text('tempRouteList : ${tempRouteList}'),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              child: Text("Go to Home"),
            ),
          ],
        ),
      ),
    );
  }
}

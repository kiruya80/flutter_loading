import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../base/route/route_state.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
///
///

class ThirdPage extends StatefulWidget {
  final bool? isLoading;

  const ThirdPage({super.key, this.isLoading = false});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends RouteState<ThirdPage> {
  @override
  Future<void> readyWidget() async {
    // await Future.delayed(const Duration(seconds: 5));
    // LoadingDialog().clear(closeContext: context);
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
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/FourthPage');
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

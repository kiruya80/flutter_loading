import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../loading_dialog.dart';
import '../util/print_log.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
///
///

class ThirdPage extends StatefulWidget {
  final bool? isLoading;

  const ThirdPage({super.key, this.isLoading = false});

  // const ThirdPage({super.key});

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

///
///
///
class _ThirdPageState extends State<ThirdPage> {
  @override
  void initState() {
    super.initState();
    // final bool isLoading = ModalRoute.of(context)?.settings.arguments as bool;
    QcLog.d('initState 11===  ${context.widget} / ${widget.isLoading} , ${LoadingDialog().context.toString()}');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // final currentRoute = ModalRoute.of(context!);
      // QcLog.i('Current Route: ${currentRoute?.settings.name} , ${currentRoute.toString()}');
      // LoadingDialog().clear();
      // if (widget.isLoading == true) {
      //   LoadingDialog().show(context);
      // }
      // await Future.delayed(const Duration(seconds: 5));
      // setState(() async {
      //   LoadingOverlay.hide();
      // });
    });
  }

  @override
  void activate() {
    super.activate();
    print('activate 11=== ');
  }

  @override
  void dispose() {
    super.dispose();
    print('dispose 11=== ');
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
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/FourthPage');
              },
              child: Text("Go to Fourth Page"),
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
              onPressed: () async {
                LoadingDialog().clear(closeContext: context);
              },
              child: Text("로딩 이미지 clear "),
            ),
          ],
        ),
      ),
    );
  }
}

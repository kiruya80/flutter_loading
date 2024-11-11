import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_dialog/page/third_page.dart';

import '../loading_dialog.dart';


///
/// 생성일 : 2024. 11. 11.
/// class 설명
///
///

class LoadingDialogPage extends StatefulWidget {
  @override
  State<LoadingDialogPage> createState() => _LoadingDialogPageState();
}

class _LoadingDialogPageState extends State<LoadingDialogPage> {
  bool isCanPop = false;
  bool isMoveLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("LoadingDialogPage")),
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
            height: 20,
          ),
          SwitchListTile(
            title: const Text("페이지 이동 후 로딩"),
            value: isMoveLoading,
            onChanged: (bool value) {
              setState(() {
                isMoveLoading = !isMoveLoading;
              });
            },
            secondary: const Icon(Icons.lightbulb_outline),
          ),

          const SizedBox(
            height: 50,
          ),

          ElevatedButton(
            onPressed: () async {
              LoadingDialog().show(context, isCanPop: isCanPop);
            },
            child: Text("${isCanPop ? "백키 가능" : "백키 불가"} , 로딩"),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              LoadingDialog().show(context, isCanPop: isCanPop);
              await Future.delayed(const Duration(seconds: 5));
              LoadingDialog().hide(closeContext: context);
              // Navigator.pushNamed(context, '/ThirdPage', arguments: isCanPop);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ThirdPage(
                            isLoading: isMoveLoading,
                          )));
            },
            child: Text("${isCanPop ? "백키 가능" : "백키 불가"} , 로딩 5초 후 ThirdPage 이동"),
          ),

          const SizedBox(
            height: 50,
          ),

          ElevatedButton(
            onPressed: () async {
              LoadingDialog().showLoadingRoute(context, isCanPop: isCanPop);
            },
            child: Text("${isCanPop ? "백키 가능" : "백키 불가"} , DialogRoute 로딩"),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) => CustomDialog(),
              );
            },
            child: Text("CustomDialog()"),
          ),
          ElevatedButton(
            onPressed: () async {
              LoadingDialog().show(context, isCanPop: isCanPop);

              final currentRouteModal = ModalRoute.of(context);
              print('Current Route: ${currentRouteModal?.settings.name} /'
                  ' ${currentRouteModal?.isCurrent} /'
                  ' ${currentRouteModal?.isActive} / '
                  ' ${currentRouteModal?.isFirst} / '
                  ' ${currentRouteModal?.settings.toString()}');

              // 최상위 네비게이터의 정보 가져오기
              final currentRoute =
                  ModalRoute.of(Navigator.of(context, rootNavigator: true).context);
              print('Current Route: ${currentRoute?.settings.name} /'
                  ' ${currentRoute?.isCurrent} /'
                  ' ${currentRoute?.isActive} / '
                  ' ${currentRoute?.isFirst} / '
                  ' ${currentRoute?.settings.toString()}');

              final route = ModalRoute.of(context);
              if (route != null && route is DialogRoute) {
                final settings = route.settings;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Route name: ${settings.name ?? 'Unnamed'}")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("No DialogRoute found")),
                );
              }
            },
            child: Text("다이얼로그 정보 테스트"),
          ),

          const SizedBox(
            height: 20,
          ),

          ///
          ///
          ///
          ///
          ///
        ]),
      ),
    );
  }
}

class CustomDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Dialog Route"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("This is a dialog using DialogRoute."),
          ElevatedButton(
            onPressed: () {
              final route = ModalRoute.of(context);
              if (route != null && route is DialogRoute) {
                final settings = route.settings;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Route name: ${settings.name ?? 'Unnamed'}")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("No DialogRoute found")),
                );
              }
            },
            child: Text("Get DialogRoute Info"),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("Close"),
        ),
      ],
    );
  }
}
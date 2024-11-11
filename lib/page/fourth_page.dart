import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// 생성일 : 2024. 11. 11.
/// class 설명
/// 
///
class FourthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fourth Page")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // 특정 라우트('/')를 제외한 모든 라우트 제거 후 HomePage로 돌아가기
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              },
              child: Text("Clear Stack and Go to Home Page"),
            ),
          ],
        ),
      ),
    );
  }
}
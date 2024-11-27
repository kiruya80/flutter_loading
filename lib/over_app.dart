import 'package:flutter/material.dart';

class OverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OverHomePage(),
    );
  }
}

class OverHomePage extends StatefulWidget {
  @override
  _OverHomePageState createState() => _OverHomePageState();
}

class _OverHomePageState extends State<OverHomePage> {
  bool _isFirstOverlayOpen = false;
  bool _isSecondOverlayOpen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home Page")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showFirstOverlay(context);
          },
          child: Text("Show First Overlay"),
        ),
      ),
    );
  }

  // 첫 번째 오버레이 표시
  void _showFirstOverlay(BuildContext context) {
    _isFirstOverlayOpen = true;
    Overlay.of(context)?.insert(
      OverlayEntry(
        builder: (context) => WillPopScope(
          onWillPop: () async {
            // 첫 번째 오버레이가 열려 있는 동안 뒤로 가기 막기
            if (_isFirstOverlayOpen) return false;
            return true;
          },
          child: Stack(
            children: [
              ModalBarrier(
                dismissible: false,
                color: Colors.black54,
              ),
              Center(
                child: Material(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("First Overlay"),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            _isFirstOverlayOpen = false;
                            _showSecondOverlay(context); // 두 번째 오버레이 표시
                          },
                          child: Text("Show Second Overlay"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 두 번째 오버레이 표시
  void _showSecondOverlay(BuildContext context) {
    _isSecondOverlayOpen = true;
    Overlay.of(context)?.insert(
      OverlayEntry(
        builder: (context) => WillPopScope(
          onWillPop: () async {
            // 두 번째 오버레이가 열려 있는 동안 뒤로 가기 막기
            if (_isSecondOverlayOpen) return false;
            return true;
          },
          child: Stack(
            children: [
              ModalBarrier(
                dismissible: false,
                color: Colors.black54,
              ),
              Center(
                child: Material(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("Second Overlay"),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            _isSecondOverlayOpen = false;
                            Navigator.of(context).pop(); // 두 번째 오버레이 닫기
                          },
                          child: Text("Close Second Overlay"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

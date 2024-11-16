# loading_dialog

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

/// buildRunner 실행시키는 명령어(Generator 적용하여 gr파일 생성)
/// 한번만 실행: flutter packages pub run build_runner build
/// 바뀔 때마다 실행: flutter packages pub run build_runner watch
/// pub finish with exit code 78 error 뜰 경우:
/// flutter pub run build_runner watch --delete-conflicting-outputs
///
/// 이 떄, build_runner watch로 했기 때문에 flutter_router.dart 파일에
/// 변경사항이 생길 경우 자동으로 flutter_router.gr.dart 파일이 변경됩니다.
///
/// 애니메이션 링크: [https://pub.dev/packages/auto_route#custom-route-transitions]
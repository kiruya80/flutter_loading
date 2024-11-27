import 'package:flutter/cupertino.dart';
import '../mixin/route_aware_mixin.dart';
import '../base_state.dart';

///
/// 생성일 : 2024. 11. 14.
/// class 설명
///
///  class _HomePageState extends RouteAwareState<HomePage> {
///
/// 현재 화면 상태를 알아보기 위한
/// app에 등록된 RouteObserver를 가져와 구독하여 체크한다
/// main app에 navigatorObservers -  RouteObserver를 등록해야한다
///
/// 공통 처리는 쉬워지겠지만 state가 더 다양해지면 종속적이게 될듯
///
abstract class RouteState<T extends StatefulWidget> extends BaseState<T>
    with RouteAwareMixin<T> // with RouteAware
{}

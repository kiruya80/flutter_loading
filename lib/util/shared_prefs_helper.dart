import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

enum SharedPrefsKey {
  SampleKey,
}

SharedPrefsHelper? _pref;

/// 미리 SharedPrefsHelper 가 생성되었거나, 적당한 Delay이후 사용하는곳만 사용 권장
SharedPrefsHelper getSharedPrefsHelper() {
  if (_pref == null) {
    _pref = SharedPrefsHelper._getInstance();
    _pref!._init();
  }
  return _pref!;
}

/// SharedPrefsHelper 객체를 리턴한다.
/// api를 바로 사용하는 경우 await로 호출한다.
Future<SharedPrefsHelper> getSharedPrefsHelperAsync() async {
  if (_pref == null) {
    _pref = SharedPrefsHelper._getInstance();
    await _pref!._init();
  }
  return _pref!;
}

/// SharedPreferences 사용을 규격화 하기 위해 정의한 api
/// instance는 다음 둘중하나를 사용
/// getSharedPrefsHelperAsync()
/// getSharedPrefsHelper() - 사용시 내부적으로 SharedPreferences 를 얻어올때 async로
///                          동작하므로, 미리 SharedPreferences가 생성되었거나,
///                          적당한 Delay이후 사용하는곳만 사용 권장
class SharedPrefsHelper {
  // ----------------------------------------------------------------------
  // 싱글톤 세팅
  static final SharedPrefsHelper _instance = SharedPrefsHelper._internal();

  SharedPrefsHelper._internal();

  late SharedPreferences _prefs;

  static SharedPrefsHelper _getInstance() {
    return _instance;
  }

  _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  List<String> getStringList(String key,
      {List<String> defaultValue = const []}) {
    return _prefs.getStringList(key) ?? defaultValue;
  }

  Future setStringList(String key, List<String> value) async {
    await _prefs.setStringList(key, value);
  }

  void remove(String key) {
    _prefs.remove(key);
  }

  Future clearAll() async {
    await _prefs.clear();
  }

  // EasyQuotationTempData? getEasyQuotationTempData(String dataStr) {
  //   String dataStr =
  //   sharedPrefsHelper.getString(SharedPrefsKey.StringEasyQuotationTempData);
  //
  //   if (easyQuotationTempDataStr.isNotEmpty && easyQuotationTempDataStr != "") {
  //     try {
  //       var dataJson = json.decode(dataStr);
  //       var easyQuotationTempData = EasyQuotationTempData.fromJson(dataJson);
  //
  //       return easyQuotationTempData;
  //     } catch (e) {
  //       return null;
  //     }
  //   } else {
  //     return null;
  //   }
  // }

  // void updateEnrollmentData(EasyQuotationTempData? easyQuotationTempData) {
  //   if (easyQuotationTempData != null) {
  //     /// 설계 시간은 이후 어어하기 기준에 따라 변경 가능
  //     sharedPrefsHelper.setString(
  //         SharedPrefsKey.StringEasyQuotationTempData, easyQuotationTempData.toBody());
  //   } else {
  //     sharedPrefsHelper.setString(SharedPrefsKey.StringEasyQuotationTempData, "");
  //   }
  // }
}

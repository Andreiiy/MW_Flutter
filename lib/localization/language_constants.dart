import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'app_localization.dart';

const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String RUSSIAN = 'ru';
const String HEBREW = 'he';

String currentLanguageCode = "";


Future<Locale> setLocale(String languageCode) async {
  currentLanguageCode = languageCode;
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  return _locale(languageCode);
}
String getCurrentLanguageCode(){
  return currentLanguageCode;
}

Future<String> getLanguageCode() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
  if(languageCode == "he")
    return "IL";
  else if(languageCode == "en")
    return "US";
  else
    return "RU";
  }
Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, 'US');
    case RUSSIAN:
      return Locale(RUSSIAN, "RU");
    case HEBREW:
      return Locale(HEBREW, "IL");
    default:
      return Locale(ENGLISH, 'US');
  }
}

String? getTranslated(BuildContext context, String key) {
  return AppLocalization.of(context)!.translate(key);
}
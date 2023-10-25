import 'package:shared_preferences/shared_preferences.dart';

import '../commons/all.dart';

const String prefSelectedLanguageCode = Constants.languageCodeDefault;

Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(prefSelectedLanguageCode, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(prefSelectedLanguageCode) ??
      Constants.languageCodeDefault;
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  return languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : const Locale(Constants.languageCodeDefault, '');
}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  fontFamilyBold = selectedLanguageCode == Constants.languageCodeAr
      ? 'Tajawal-Bold'
      : 'BentonSans-Bold';
  fontFamilyLight = selectedLanguageCode == Constants.languageCodeAr
      ? 'Tajawal-Light'
      : 'BentonSans-Light';
  fontFamilyBook = selectedLanguageCode == Constants.languageCodeAr
      ? 'Tajawal-Regular'
      : 'BentonSans-Book';
  fontFamilyRegular = selectedLanguageCode == Constants.languageCodeAr
      ? 'Tajawal-Regular'
      : 'BentonSans-Regular';
  fontFamilyMedium = selectedLanguageCode == Constants.languageCodeAr
      ? 'Tajawal-Medium'
      : 'BentonSans-Medium';
  Locale locale = await setLocale(selectedLanguageCode);
  Get.updateLocale(locale);
  // MyApp.setLocal(Get.context!, locale);
}

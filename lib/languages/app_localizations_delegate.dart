import '../commons/all.dart';
import 'language.dart';
import 'language_ar.dart';
import 'language_en.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => [Constants.languageCodeEn, Constants.languageCodeAr].contains(locale.languageCode);

  @override
  Future<Languages> load(Locale locale) => _load(locale);

  static Future<Languages> _load(Locale locale) async {
    switch (locale.languageCode) {
      case Constants.languageCodeEn:
        return LanguageEn();
      case Constants.languageCodeAr:
        return LanguageAr();
      default:
        return LanguageEn();
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}

import 'package:bcsports_mobile/services/locale/localization/locale_names.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  final Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  final String _localeKey = "locale";

  setLocale(String localeCode) async {
    final pref = await _pref;
    await pref.setString(_localeKey, localeCode);
  }

  Future<String> getLocale() async {
    final pref = await _pref;
    final locale = pref.get(_localeKey);
    if (locale == null) {
      return LocaleNames.ru;
    }
  
    return locale as String;
  }
}

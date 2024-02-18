import 'package:bcsports_mobile/services/locale/localization/locale_names.dart';
import 'package:bcsports_mobile/services/locale/preferences_service.dart';

class LocalizationService {
  String currentLocale = LocaleNames.en;

  final PreferencesService _prefs;

  LocalizationService(this._prefs);

  Future<String> getLocale() async => await _prefs.getLocale();

  Future<void> setLocale(String newLocale) async =>
      await _prefs.setLocale(newLocale);

  setInitialLocale() async {
    currentLocale = await getLocale();
    print(currentLocale);
  }

  Future<void> changeLocale(String newLocale) async {
    await setLocale(newLocale);
    currentLocale = newLocale;
  }
}

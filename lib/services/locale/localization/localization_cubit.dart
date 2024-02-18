import 'package:bcsports_mobile/services/locale/localization/localization_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  final LocalizationService localizationService;

  LocalizationCubit(this.localizationService) : super(LocalizationInitial()) {
    setInitialLocale();
  }

  Future<void> changeLocale(String newLocale) async {
    await localizationService.changeLocale(newLocale);
    print(localizationService.currentLocale);
    emit(LocalizationChanged());
  }

  Future<void> setInitialLocale() async {
    await localizationService.setInitialLocale();
    emit(LocalizationChanged());
  }
}

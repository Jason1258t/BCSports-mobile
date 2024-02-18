import 'package:bcsports_mobile/l10n/l10n.dart';
import 'package:bcsports_mobile/localization/app_localizations.dart';
import 'package:bcsports_mobile/services/locale/localization/locale_names.dart';
import 'package:bcsports_mobile/services/locale/localization/localization_cubit.dart';
import 'package:bcsports_mobile/utils/colors.dart';
import 'package:bcsports_mobile/utils/fonts.dart';
import 'package:bcsports_mobile/widgets/buttons/button_back.dart';
import 'package:bcsports_mobile/widgets/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class ProfileLanguageScreen extends StatefulWidget {
  const ProfileLanguageScreen({super.key});

  @override
  State<ProfileLanguageScreen> createState() => _ProfileLanguageScreenState();
}

class _ProfileLanguageScreenState extends State<ProfileLanguageScreen> {
  late final LocalizationCubit localeBloc;

  @override
  void initState() {
    localeBloc = BlocProvider.of<LocalizationCubit>(context);
    super.initState();
  }

  void onLocaleTap(String newLocale) {
    localeBloc.changeLocale(newLocale);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            ButtonBack(onTap: () {
              Navigator.pop(context);
            }),
            Text(
              AppLocalizations.of(context)!.language,
              style: AppFonts.font18w600,
            ),
            const SizedBox(
              width: 50,
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
            color: AppColors.black_s2new_1A1A1A,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LocaleLineWidget(
              isSelected: localeBloc.localizationService.currentLocale ==
                  LocaleNames.en,
              onTap: () => onLocaleTap(LocaleNames.en),
              name: "English",
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 6),
              height: 1,
              width: double.infinity,
              color: AppColors.grey_2F2F2F,
            ),
            LocaleLineWidget(
              isSelected: localeBloc.localizationService.currentLocale ==
                  LocaleNames.ru,
              onTap: () => onLocaleTap(LocaleNames.ru),
              name: "Русский",
            ),
          ],
        ),
      ),
    );
  }
}

class LocaleLineWidget extends StatelessWidget {
  final String name;
  final bool isSelected;
  final Function onTap;

  const LocaleLineWidget({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              name,
              style: AppFonts.font14w500.copyWith(color: AppColors.white),
            ),
            Opacity(
                opacity: isSelected ? 1 : 0,
                child: SvgPicture.asset("assets/icons/accept.svg")),
          ],
        ),
      ),
    );
  }
}

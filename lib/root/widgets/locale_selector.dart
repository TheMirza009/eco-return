import 'package:country_flags/country_flags.dart';
import 'package:eco_return/core/base/controllers/locale_controller.dart';
import 'package:eco_return/core/base/controllers/locale_provider.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocaleSelectorPopup extends ConsumerWidget {
  const LocaleSelectorPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the current locale from the Riverpod provider
    final localeNotifier = ref.read(localeProvider.notifier);
    final supportedLocales = LocaleController.supportedLocales; // Access directly

    return PopupMenuTheme(
      data: PopupMenuThemeData(
        color: const Color.fromARGB(255, 235, 240, 245),
      ),
      child: PopupMenuButton<Locale>(
        onSelected: (Locale newLocale) {
          // Set the selected locale using Riverpod
          localeNotifier.setLocale(newLocale);
        },
        itemBuilder: (BuildContext context) {
          return supportedLocales.map((locale) {
            return PopupMenuItem<Locale>(
              value: locale,
              child: Row(
                children: [
                  CountryFlag.fromLanguageCode(
                    locale.languageCode,
                    height: ThemeConstants.screenHeight * 2 / 100,
                    width: ThemeConstants.screenHeight * 3 / 100,
                    shape: RoundedRectangle(3),
                  ),
                  SizedBox(width: ThemeConstants.screenHeight * 1 / 100),
                  Text(LocaleController.getLanguageName(locale.languageCode)),
                ],
              ),
            );
          }).toList();
        },
      ),
    );
  }
}

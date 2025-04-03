import 'package:country_flags/country_flags.dart';
import 'package:eco_return/core/base/controllers/languages.dart';
import 'package:eco_return/core/base/controllers/locale_controller.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguageSelectionScreen extends ConsumerWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String languageCode = Localizations.localeOf(context).languageCode;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: EcoIcon(path: IconPaths.chevron, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: ThemeConstants.screenHeight * 8.5 / 100),
            Text(
              "Language",
              style: GoogleFonts.montserrat(
                fontSize: ThemeConstants.screenHeight * 0.03,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: ThemeConstants.screenHeight * 0.01),
            Row(
              children: [
                Text("Current Locale: $languageCode"),
                SizedBox(width: ThemeConstants.screenWidth * 2 / 100),
                CountryFlag.fromLanguageCode(
                  languageCode,
                  height: ThemeConstants.screenHeight * 2 / 100,
                  width: ThemeConstants.screenHeight * 3 / 100,
                  shape: RoundedRectangle(3),
                ),
              ],
            ),
            SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300), // Fade animation duration
                child: ListView(
                  key: ValueKey<String>(languageCode), // Ensures that the ListView rebuilds on language change
                  children: Languages.supportedLocales.map((locale) {
                    bool isSelected = locale.languageCode == languageCode;
                    return Column(
                      children: [
                        ListTile(
                          tileColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: isSelected ? ThemeConstants.ecoGreen : ThemeConstants.lightBorder,
                              width: isSelected ? 3 : 2,
                            ),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          leading: CountryFlag.fromLanguageCode(
                            locale.languageCode,
                            height: ThemeConstants.screenHeight * 2 / 100,
                            width: ThemeConstants.screenHeight * 3 / 100,
                            shape: RoundedRectangle(3),
                          ),
                          title: Text(
                            Languages.getLanguageName(locale.languageCode),
                            style: GoogleFonts.montserrat(
                              color: const Color.fromARGB(255, 14, 25, 32),
                              fontWeight: FontWeight.w500,
                              fontSize: ThemeConstants.screenHeight * 1.9 / 100,
                            ),
                          ),
                          onTap: () {
                            ref.read(localeProvider.notifier).setLocale(locale);
                          },
                        ),
                        SizedBox(height: ThemeConstants.screenHeight * 1.6 / 100),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

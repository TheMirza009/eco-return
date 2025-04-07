import 'dart:convert';

import 'package:country_flags/country_flags.dart';
import 'package:eco_return/core/base/controllers/locale_controller.dart';
import 'package:eco_return/core/base/controllers/locale_provider.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/widgets/locale_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleTest extends ConsumerStatefulWidget {
  final void Function()? onRequestTapped;
  const LocaleTest({super.key, this.onRequestTapped});

  @override
  _LocaleTestState createState() => _LocaleTestState();
}

class _LocaleTestState extends ConsumerState<LocaleTest> {
  var exampleString = "loading";
  var exampleMap = {"Value": 123};

  loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final savedLanguageCode = prefs.getString('example');
      exampleString = (savedLanguageCode!);
    } catch (e) {
      print(e);
    }

    print(123);
    setState(() {});
  }

  setPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('example', json.encode(exampleMap));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final localeNotifier = ref.read(localeProvider.notifier);
    String languageCode = Localizations.localeOf(context).languageCode;

    CountryFlag flag = CountryFlag.fromLanguageCode(
      languageCode,
      height: ThemeConstants.screenHeight * 2 / 100,
      width: ThemeConstants.screenHeight * 3 / 100,
      shape: RoundedRectangle(3),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [LocaleSelectorPopup()],
      ),
      body: ListView(
        children: [
          Text("Example Map: $exampleString"),
          ElevatedButton(onPressed: () => setPrefs(), child: Text("Set Prefs")),
          ElevatedButton(
              onPressed: () => loadPrefs(), child: Text("Load Prefs")),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: (ThemeConstants.screenHeight * 15) / 100),
                Text(
                  "${AppLocalizations.of(context)!.welcome}, Josh!",
                  style: GoogleFonts.montserrat(
                      fontSize: (ThemeConstants.screenHeight * 3) / 100,
                      fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    Text("Current Locale: ${languageCode}"),
                    SizedBox(width: ThemeConstants.screenWidth * 2 / 100),
                    flag,
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            localeNotifier.setLocale(const Locale('en')),
                        child: const Text("Switch to English"),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () =>
                            localeNotifier.setLocale(const Locale('hu')),
                        child: const Text("Váltás magyarra"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

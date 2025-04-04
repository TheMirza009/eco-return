import 'package:eco_return/core/base/controllers/languages.dart';
import 'package:eco_return/core/collections/illustration_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/payment_methods/payment_method_screen.dart';
import 'package:eco_return/root/components/requests/bottle_number/bottle_number_component.dart';
import 'package:eco_return/root/components/requests/bottle_number/pickup_info_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class RequestPickup extends StatelessWidget {
  const RequestPickup({super.key});

  @override
  Widget build(BuildContext context) {

     // Locale for translations
      AppLocalizations locale = LocaleController.getLocale(context);

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: (ThemeConstants.screenHeight * 15) / 100),
                Text(
                  locale.requestPickup,
                  style: GoogleFonts.montserrat(
                    fontSize: (ThemeConstants.screenHeight * 3) / 100,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: (ThemeConstants.screenHeight * 1) / 100),
                Text(
                  locale.pickupAgentSpecificInformation
                ),
                SizedBox(height: (ThemeConstants.screenHeight * 3) / 100),
                Image.asset(Illustrations.bottle),
                SizedBox(height: (ThemeConstants.screenHeight * 8) / 100),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    locale.pickupDetails,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontSize: (ThemeConstants.screenHeight * 1.3) / 100,
                      color: Theme.of(context).colorScheme.primary.withAlpha(150),
                    ),
                  ),
                ),
                SizedBox(height: (ThemeConstants.screenHeight * 1) / 100),
                ElevatedButton(
                  style: ElevatedButton.styleFrom( backgroundColor: ThemeConstants.ecoGreen ),
                  onPressed: () => Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => PickupInfoScreen(),
                      // builder: (_) => BottleNumberScreen(),
                    ),
                  ),
                  child: Text(
                    locale.requestPickup,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: (ThemeConstants.screenHeight * 1.9) / 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

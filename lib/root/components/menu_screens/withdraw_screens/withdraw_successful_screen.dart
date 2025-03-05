import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/collections/illustration_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/home/bottom_nav_screen.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WithdrawSuccessfulScreen extends StatelessWidget {
  const WithdrawSuccessfulScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: ThemeConstants.screenHeight * 5 / 100,
                ),
                Text(
                  "Withdrawal confirmed!",
                  style: GoogleFonts.montserrat(
                    fontSize: ThemeConstants.screenHeight * 3.2 / 100,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "The money is on its way!",
                  style: GoogleFonts.montserrat(
                    fontSize: ThemeConstants.screenHeight * 1.5 / 100,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Image.asset(Illustrations.tick),
            ),
            TextButton(
              onPressed: () => Future.delayed(
                Duration(milliseconds: 300),
                () => Navigator.pushAndRemoveUntil(
                  context,
                  CupertinoPageRoute(builder: (_) => HomeScreenBottomNav()),
                  (_) => false,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "← ",
                    style: GoogleFonts.dmSans(
                      fontSize: ThemeConstants.screenHeight * 2 / 100,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 38, 172, 163)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0, bottom: 1.5),
                    child: Text(
                      "Back to home",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        color:const Color.fromARGB(255, 38, 172, 163)
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

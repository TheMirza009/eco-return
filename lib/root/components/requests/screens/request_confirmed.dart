import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/collections/illustration_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/home/bottom_nav_screen.dart';
import 'package:eco_return/root/widgets/eco_animated_circle.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestConfirmedScreen extends StatelessWidget {
  const RequestConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(height: ThemeConstants.screenHeight * 5 / 100,),
              Text(
                "Request confirmed!",
                style: GoogleFonts.montserrat(
                  fontSize: ThemeConstants.screenHeight * 3.5 / 100,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "Our Pickup agent is on his way!",
                style: GoogleFonts.montserrat(
                  fontSize: ThemeConstants.screenHeight * 1.5 / 100,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Image.asset(Illustrations.rider),
          ),
          GestureDetector(
            onTap: () => Navigator.pushAndRemoveUntil(
              context,
              CupertinoPageRoute(builder: (_) => HomeScreenBottomNav()),
              (_) => false,
            ),
            child: Container(
              padding: const EdgeInsets.all(4), // Adds padding between the circle and the icon
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: ThemeConstants.ecoGreen, // Adjust the color as needed
                  width: 3,
                ),
              ),
              child: EcoIcon(
                path: IconPaths.tick,
                size: ThemeConstants.screenHeight *  8 / 100, // Slightly reduce size for padding effect
              ),
            ),
          )

          // AnimatedArc(
          //     page: 5,
          //     onPressed: () => Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (_) => HomeScreenBottomNav()), (_) => false),
          //     size: ThemeConstants.screenHeight * 8 / 100,
          //   ),
        ],
      ),
    );
  }
}

import 'dart:ffi';

import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: (ThemeConstants.screenHeight * 8) / 100),
            Text(
              "Location Sharing",
              style: GoogleFonts.montserrat(
                  fontSize: (ThemeConstants.screenHeight * 3) / 100,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 1) / 100),
            Spacer(),
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  EcoIcon(path: IconPaths.stroke_location),
                  SizedBox(width: ThemeConstants.screenWidth * 3 / 100),
                  Text(
                    "Live location",
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

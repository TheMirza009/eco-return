import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SectionLabel extends StatelessWidget {
  final String? label;
  const SectionLabel({super.key, this.label = ""});

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Container(
            height: ThemeConstants.screenWidth * 8 / 100,
            width: ThemeConstants.screenWidth * 1.5 / 100,
            decoration: BoxDecoration(
              color: ThemeConstants.ecoGreen, // Set the background color
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(4),
                bottomRight: Radius.circular(4),
              ),
            ),
          ),
          SizedBox(width: ThemeConstants.screenWidth * 4 / 100),
          Text(
            label!,
            style: GoogleFonts.montserrat(
              fontSize: ThemeConstants.screenWidth * 4 / 100,
              color: Theme.of(context).colorScheme.primary.withAlpha(100),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      );
  }
}

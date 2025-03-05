import 'package:eco_return/core/collections/gradients.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'dart:math';

class StatTile extends StatelessWidget {
  final String title;
  final Widget? icon;
  final String subtitle;
  final double height;
  final double width;
  final List<Color>? gradient;

  const StatTile({
    super.key,
    required this.title,
    required this.icon,
    required this.subtitle,
    this.height = 300,
    this.width = 100,
    this.gradient,
  });

  static int? _previousIndex;

  @override
  Widget build(BuildContext context) {
    final screenHeight = ThemeConstants.screenHeight * 30 / 100; // Current: 261.81
    final screenWidth = ThemeConstants.screenWidth * 40 / 100; // Current 157.09

    final gradientMap = {
      0: Gradients.ecoGreen,
      1: Gradients.amberRed,
      2: Gradients.birchWood,
      3: Gradients.blackMetal,
      4: Gradients.violetBlue,
      5: Gradients.violetRed,
      6: Gradients.velvetBlue,
      7: Gradients.meteorBlack,

      8: [Colors.green, Colors.teal],
      9: [Colors.red, Colors.orange],
      10: [Colors.blue, Colors.indigo],
      11: [Colors.purple, Colors.pink],
      12: [Colors.yellow, Colors.brown],
      13: [Colors.cyan, Colors.lightBlue],
      14: [Colors.amber, Colors.deepOrange],
      15: [Colors.lime, Colors.greenAccent],
    };

    // final int index = Random().nextInt(gradientMap.length);

    // Generate a random index that avoids repetition
    int newIndex;
    do {
      newIndex = Random().nextInt(gradientMap.length);
    } while (newIndex == _previousIndex);

    _previousIndex = newIndex;


    return Container(
      height: screenHeight,
      width: screenWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: RadialGradient(
              center: Alignment.topLeft, // Moves the gradient center to the top left
              radius: 2.5, // Adjust the radius as needed
              colors: gradient ?? gradientMap[newIndex]!,
            ),
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          // Title
          Positioned(
            top: ThemeConstants.screenHeight * 0.01,
            left: ThemeConstants.screenWidth * 0.03,
            child: Text(
              title,
              style: GoogleFonts.montserrat(
                fontSize: ThemeConstants.screenWidth * 4.6 / 100,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          // Icon in center
          Center(
            child: icon
          ),
          // Subtitle
          Positioned(
            bottom: ThemeConstants.screenHeight * 0.01,
            left: ThemeConstants.screenWidth * 0.03,
            child: SizedBox(
              width: width,
              child: Text(
                subtitle,
                style: GoogleFonts.montserrat(
                  fontSize: ThemeConstants.screenWidth * 4.6 / 100,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

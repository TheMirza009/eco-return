import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget EcoIcon({
  String path = "Assets/icons/smile.svg", 
  Color color =  ThemeConstants.ecoGreen,
  double size = 20.8,
  }) {
  return SvgPicture.asset(
    path,
    height: size,
    colorFilter: ColorFilter.mode(
      color, // Desired color
      BlendMode.srcIn, // Ensures the color replaces the original
    ),
  );
}
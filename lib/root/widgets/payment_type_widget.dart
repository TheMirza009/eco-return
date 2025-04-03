import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class PaymentTypeWidget extends StatelessWidget {
  final String logoPath;
  final bool selected;
  final double? width;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback? onTap;

  const PaymentTypeWidget({
    Key? key,
    required this.logoPath,
    this.width,
    this.selected = false,
    this.activeColor = ThemeConstants.ecoGreen,
    this.inactiveColor = const Color.fromARGB(24, 158, 158, 158),
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double finalWidth = width ?? ThemeConstants.screenWidth / 6;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? activeColor : inactiveColor,
            width: 3,
          ),
        ),
        child: Image.asset(
          logoPath,
          width: finalWidth,
          height: ThemeConstants.screenWidth / 9,
        ),
      ),
    );
  }
}

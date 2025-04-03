import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeeAllHeader extends StatelessWidget {
  final String label;
  final void Function()? onSeeAllPressed;
  const SeeAllHeader({super.key, required this.label, required this.onSeeAllPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.montserrat(
            color: Theme.of(context).colorScheme.primary.withAlpha(100),
            fontWeight: FontWeight.w500,
          ),
        ),
        // Spacer(),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: onSeeAllPressed,
            child: Row(
              children: [
                Text(
                  "See all",
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.bold,
                    color: ThemeConstants.ecoGreen,
                  ),
                ),
                SizedBox(width: 3),
                Transform.flip(
                  flipX: true,
                  child: EcoIcon(
                    size: ThemeConstants.screenHeight * 1.5 / 100,
                    path: IconPaths.chevron,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

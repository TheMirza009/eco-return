import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelected;

  const TransactionChip({
    Key? key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style: GoogleFonts.montserrat(
          fontSize: ThemeConstants.screenWidth * 3.8 / 100,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? ThemeConstants.ecoGreen : const Color.fromARGB(255, 104, 104, 104),
        ),
      ),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // Fully rounded corners
        side: BorderSide(
          color: isSelected ? ThemeConstants.ecoGreen : ThemeConstants.lightGrey, // Dynamic border color
          width: 3, // Border width
        ),
      ),
      selected: isSelected,
      onSelected: (_) => onSelected(),
    );
  }
}

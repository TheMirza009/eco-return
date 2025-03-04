import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeslotChip extends StatelessWidget {
  final String time;
  final bool isSelected;
  final VoidCallback onSelected;

  const TimeslotChip({
    Key? key,
    required this.time,
    required this.isSelected,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
      color: WidgetStatePropertyAll(isSelected ? ThemeConstants.ecoGreen : Colors.transparent),
      backgroundColor: isSelected ? ThemeConstants.ecoGreen : Colors.transparent,
      checkmarkColor: Colors.white,
      showCheckmark: true,
      label: Text(
        time,
        style: GoogleFonts.montserrat(
          fontSize: ThemeConstants.screenWidth * 4.5 / 100,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          color: isSelected ? Colors.white : const Color.fromARGB(255, 0, 0, 0),
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

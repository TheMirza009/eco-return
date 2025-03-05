import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoneyPlate extends StatelessWidget {
  final String currentBalance;
  final String withdrawn;
  final String totalReceived;

  const MoneyPlate({
    Key? key,
    this.currentBalance = "\$0.00",
    this.withdrawn = "\$0.00",
    this.totalReceived = "\$0.00",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = ThemeConstants.screenHeight; 
    final screenWidth = ThemeConstants.screenWidth; 
    final ecoGreen =  ThemeConstants.ecoGreen; 
    final ecoGrey = const Color.fromARGB(255, 0, 155, 182);
    final ecoGradient = [
      ecoGrey,
      ecoGreen,
    ];

    return Container(
      width: screenWidth,
      height: screenHeight * 25 / 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: ecoGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Left Section (Current Balance)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Current Balance",
                style: GoogleFonts.montserrat(
                  fontSize: screenHeight * 5 / 100 / 3,
                  color: Colors.white,
                ),
              ),
              Text(
                currentBalance,
                style: GoogleFonts.montserrat(
                  fontSize: screenHeight * 5 / 100,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: ThemeConstants.screenHeight * 3 / 100,),
          // Bottom Row
          Row(
            children: [
              // Withdrawn
              _buildInfoColumn(
                title: "Withdrawn",
                value: withdrawn,
                screenHeight: screenHeight,
                isSmall: true,
              ),
              SizedBox(width: screenWidth / 4),
              // Total Received
              _buildInfoColumn(
                title: "Total Received",
                value: totalReceived,
                screenHeight: screenHeight,
                isSmall: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper Widget for Info Columns
  Widget _buildInfoColumn({
    required String title,
    required String value,
    required double screenHeight,
    bool isSmall = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.montserrat(
            fontSize: isSmall ? screenHeight * 3 / 100 / 2 : screenHeight * 5 / 100 / 3,
            color: Colors.white,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.montserrat(
            fontSize: isSmall ? screenHeight * 3 / 100 : screenHeight * 5 / 100,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

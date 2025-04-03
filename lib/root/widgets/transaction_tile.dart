import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/data/enums/transaction_type.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TransactionTile extends StatelessWidget {
  final int bottles;
  final DateTime? time;
  final int amount;
  final TransactionType transactionType; 

  const TransactionTile({
    super.key,
    required this.bottles,
    required this.amount,
    required this.time,
    this.transactionType = TransactionType.receive,
  });

  String formatDateTime(DateTime? time) {
    if (time == null) return "3:12 PM - Today";

    final now = DateTime.now();
    final isToday =
        time.day == now.day && time.month == now.month && time.year == now.year;
    final isYesterday = time.day == now.subtract(const Duration(days: 1)).day &&
        time.month == now.month &&
        time.year == now.year;

    // Format time in "h:mm a" style (e.g., 3:12 PM)
    final formattedTime = DateFormat('h:mm a').format(time);

    // Format date part
    final formattedDate = isToday
        ? "Today"
        : isYesterday
            ? "Yesterday"
            : "${time.day} ${_monthName(time.month)}";

    return "$formattedTime - $formattedDate";
  }

  String _monthName(int month) {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return monthNames[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // Rounded corners
        child: Container(
          color: Theme.of(context).colorScheme.surfaceContainer,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Ensure proper alignment
              crossAxisAlignment: CrossAxisAlignment.start, // Align items to the top
              children: [
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    transactionType == TransactionType.receive
                        ? Icon(Icons.call_received, color: ThemeConstants.ecoGreen)
                        : Padding(
                          padding: const EdgeInsets.only(right: 2.0, top: 5.0),
                          child: EcoIcon(path: IconPaths.stroke_withdraw, size: ThemeConstants.screenWidth * 4.5 / 100),
                        ),
                    SizedBox(width: ThemeConstants.screenWidth * 1 / 100),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transactionType == TransactionType.receive
                              ? "$bottles bottles"
                              : "Bank transfer",
                          style: GoogleFonts.montserrat(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: ThemeConstants.screenWidth * 4.6 / 100,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          formatDateTime(time),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  "$amount\$",
                  style: GoogleFonts.montserrat(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: ThemeConstants.screenWidth * 4.6 / 100,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/requests/bottle_number/pickup_info_screen.dart';
import 'package:eco_return/root/components/requests/screens/location_screen.dart';
import 'package:eco_return/root/widgets/date_dropdown.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:eco_return/root/widgets/eco_textfield.dart';
import 'package:eco_return/root/widgets/timeslot_chip.dart';
import 'package:eco_return/root/widgets/transaction_chip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeSlotComponent extends StatelessWidget {
  const TimeSlotComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> timeslot = ValueNotifier(0);
    final List<String> dummyTimeslots = [
      "9:00 AM - 11:00 AM",
      "2:00 AM - 6:00 AM",
      "6:00 PM - 8:00 PM",
      "4:00 PM - 9:00 PM",
      "10:00 PM - 11:00 PM"
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: (ThemeConstants.screenHeight * 0) / 100),
            Text(
              "Pick a Timeslot",
              style: GoogleFonts.montserrat(
                fontSize: (ThemeConstants.screenHeight * 3) / 100,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 1) / 100),
            Text( "Our pickup agent will arrive for the pickup within the specified timeframe."),
            SizedBox(height: (ThemeConstants.screenHeight * 3) / 100),
            DateDropdown(),

            SizedBox(height: ThemeConstants.screenHeight * 2 / 100),

            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Pick one of the timeslots \navailable to our pickup agents.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: (ThemeConstants.screenHeight * 1.3) / 100,
                    color: Theme.of(context).colorScheme.primary.withAlpha(150),
                  ),
                ),
              ),
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 1) / 100),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: timeslot,
                builder: (context, value, child) {
                  return ListView(
                    children: [
                      for (int i = 0; i < dummyTimeslots.length; i++)
                        Padding(
                          padding: EdgeInsets.only(
                            left: i.isOdd ? 60.0 : 0.0,
                            right: i.isEven ? 60.0 : 0.0,
                            bottom: 10.0, // Space between chips
                          ),
                          child: i == dummyTimeslots.length
                              ? SizedBox(height: 200)
                              : TimeslotChip(
                                  time: dummyTimeslots[i],
                                  isSelected: timeslot.value == i + 1,
                                  onSelected: () => timeslot.value = i + 1,
                                ),
                        ),
                        const SizedBox(height: 100),
                    ],
                  );
                },
              ),
            ),
            // TextButton(
            //   style: TextButton.styleFrom(
            //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12), // Removes default padding
            //     minimumSize: Size.zero,  // Allows the button to shrink to content size
            //     tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduces touch target padding
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(18.5), // Optional: Adjust border radius
            //       side: BorderSide(width: 2, color: ThemeConstants.ecoGreen),
            //     ),
            //   ),
            //   onPressed: () => Navigator.push(
            //     context,
            //     CupertinoPageRoute(
            //       builder: (_) => LocationScreen(),
            //     ),
            //   ),
            //   child: Row(
            //     mainAxisSize: MainAxisSize.min, // Makes the Row as wide as its content
            //     children: [
            //       EcoIcon(path: IconPaths.stroke_location),
            //       SizedBox(width: ThemeConstants.screenWidth * 3 / 100),
            //       Text(
            //         "Live location",
            //         style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(height: (ThemeConstants.screenHeight * 3) / 100),
          ],
        ),
      ),
    );
  }
}

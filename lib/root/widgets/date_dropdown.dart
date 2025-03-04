import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const List<String> _dummydates = [
  "12th March 2025",
  "15th March 2025",
  "16th March 2025",
  "20th March 2025"
];

class DateDropdown extends StatefulWidget {
  final List? dates;
  const DateDropdown({super.key, this.dates = _dummydates});

  @override
  State<DateDropdown> createState() => _DateDropdownState();
}

class _DateDropdownState extends State<DateDropdown> {
  String selectedDate = "12/12/12";

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final result = await showMenu<String>(
          color: Colors.white,
          popUpAnimationStyle: AnimationStyle(curve: Curves.easeInOut),
          shape: RoundedRectangleBorder(),
          context: context,

          position: RelativeRect.fromLTRB(200, 250, 200, 100),
          items: [
            for (int i = 0; i < widget.dates!.length; i++) ...[
              PopupMenuItem<String>(
                value: widget.dates![i],
                child: Text(
                  widget.dates![i],
                  style: GoogleFonts.montserrat(fontSize: 14),
                ),
              ),
            ],
          ],
        );

        if (result != null) {
          setState(() {
            selectedDate = result;
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: ThemeConstants.ecoGreen, width: 2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            EcoIcon(path: IconPaths.calender),
            SizedBox(width: ThemeConstants.screenWidth * 5 / 100),
            Text(
              "Date",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700]),
            ),
            const Spacer(),
            Text(
              selectedDate,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromARGB(137, 97, 97, 97)),
            ),
            SizedBox(width: ThemeConstants.screenWidth * 4 / 100),
            const Icon(CupertinoIcons.chevron_down, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

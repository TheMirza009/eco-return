import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DatePickerTile extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime?> onDateSelected;

  const DatePickerTile({
    Key? key,
    required this.initialDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _DatePickerTileState createState() => _DatePickerTileState();
}

class _DatePickerTileState extends State<DatePickerTile> {
  late DateTime pickedDate;

  @override
  void initState() {
    super.initState();
    pickedDate = widget.initialDate;
  }

  Future<void> pickDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: pickedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            textTheme: ThemeConstants.customTextTheme,
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      setState(() {
        pickedDate = selectedDate;
      });
      widget.onDateSelected(pickedDate); // Notify parent
    } else {
      widget.onDateSelected(null); // Notify parent that no date was selected
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: ThemeConstants.lightBorder,
            width: ThemeConstants.fieldBorderWidth),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width: 16), // Spacing
                EcoIcon(path: IconPaths.cake), // Leading icon
                SizedBox(width: 16), // Spacing
                Text(
                  "Date of Birth",
                  style: GoogleFonts.montserrat(
                      fontSize: ThemeConstants.getDynamicFontSize(15),
                      color: ThemeConstants.lightSubtitle,
                      fontWeight: FontWeight.w500), // Leading text
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: pickDate,
                  child: Text(
                    DateFormat('dd/MM/yyyy').format(pickedDate),
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey), // Trailing text
                  ),
                ),
                SizedBox(width: 2), // Spacing
                IconButton(
                  padding: EdgeInsets.zero, // Ensure zero padding
                  iconSize: 24, // Appropriate icon size
                  onPressed: pickDate,
                  icon: EcoIcon(
                    path: IconPaths.stroke_calender,
                    color: const Color.fromARGB(113, 96, 125, 139),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

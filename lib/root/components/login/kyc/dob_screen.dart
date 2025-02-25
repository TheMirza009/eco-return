import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/core/collections/illustration_paths.dart';
import 'package:eco_return/root/components/login/kyc/payment_method_screen.dart';
import 'package:eco_return/root/components/login/signUp/sign_up.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DOBScreen extends StatefulWidget {
  const DOBScreen({super.key});

  @override
  State<DOBScreen> createState() => _DOBScreenState();
}

class _DOBScreenState extends State<DOBScreen> {
  bool visibility = false;
  DateTime pickedDate = DateTime.now();

  pickDate() async {
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
            textTheme: ThemeConstants.customTextTheme.copyWith(
              headlineMedium: GoogleFonts.montserrat(
                fontWeight: FontWeight.normal, // Remove bold text
              ),
            ),
          ),
          child: child!,
        );
      },
    );             
    if (selectedDate != null) {
      setState(() {
        pickedDate = selectedDate;
      });
      print("Selected date: ${pickedDate.toLocal()}");
    } else {
      print("Date not selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: (ThemeConstants.screenHeight * 8) / 100),
            Text(
              "Birthday!",
              style: textTheme.bodyLarge,
            ),
            Text(
                "\nPlease enter your date of birth as reflected on your identification."),
            SizedBox(height: (ThemeConstants.screenHeight * 7) / 100),
            Image.asset(Illustrations.cake),
            SizedBox(height: (ThemeConstants.screenHeight * 7) / 100),
            Container(
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
                          style: GoogleFonts.montserrat(fontSize: ThemeConstants.getDynamicFontSize(15), color: ThemeConstants.lightSubtitle, fontWeight: FontWeight.w500), // Leading text
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat('dd/MM/yyyy').format(pickedDate),
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey), // Trailing text
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
            ),

            Center(
              child: Text("\nPlease pick a date to continue.",
                style: GoogleFonts.montserrat(
                  color: Theme.of(context).colorScheme.primary.withAlpha(150),
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 1.5) / 100),
            Expanded(child: SizedBox(),),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: (pickedDate.year != DateTime.now().year ||
                            pickedDate.month != DateTime.now().month ||
                            pickedDate.day != DateTime.now().day)
                    ? () => Navigator.push(
                          context, CupertinoPageRoute(builder: (_) => PaymentMethodKYC()))
                    : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>((states) => Colors.transparent ),
                  side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
                    if (pickedDate.year == DateTime.now().year &&
                        pickedDate.month == DateTime.now().month &&
                        pickedDate.day == DateTime.now().day) {
                      return const BorderSide(
                          color: Colors.grey, width: 1.5); // Grey border
                    }
                    return null; // Default style
                  }),
                ),
                child: Text(
                  "Next",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

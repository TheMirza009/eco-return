import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/requests/bottle_number/pickup_info_screen.dart';
import 'package:eco_return/root/components/requests/screens/location_screen.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:eco_return/root/widgets/eco_textfield.dart';
import 'package:eco_return/root/widgets/eco_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class PickupSummaryComponent extends StatefulWidget {
  const PickupSummaryComponent({super.key});

  @override
  State<PickupSummaryComponent> createState() => _PickupSummaryComponentState();
}

class _PickupSummaryComponentState extends State<PickupSummaryComponent> {
  String note = "";

  @override
  Widget build(BuildContext context) {
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
              "Pickup summary",
              style: GoogleFonts.montserrat(
                fontSize: (ThemeConstants.screenHeight * 3) / 100,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 1) / 100),
            Text("Please confirm the information you've entered before it can be sent to our pickup agents."),
            SizedBox(height: (ThemeConstants.screenHeight * 5) / 100),
            Expanded(
              child: ListView(
                children: [
                  EcoTile(
                    leadingIcon: EcoIcon(path: IconPaths.bottle),
                    title: "bottles",
                    trailingText: "12 bottles",
                  ),
                  SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
                  EcoTile(
                    leadingIcon: EcoIcon(path: IconPaths.home),
                    title: "address-1",
                    trailingText: "Groove street, San Andreas",
                  ),
                  SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
                  EcoTile(
                    leadingIcon: EcoIcon(path: IconPaths.home),
                    title: "address-1",
                    trailingText: "Los Santos, United States",
                  ),
                  SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
                  EcoTile(
                    leadingIcon: EcoIcon(path: IconPaths.location),
                    title: "city",
                    trailingText: "Los Santos",
                  ),
                  SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
                  EcoTile(
                    leadingIcon: EcoIcon(path: IconPaths.calender),
                    title: "date",
                    trailingText: "12/12/2012",
                  ),
                  SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
                  EcoTile(
                    leadingIcon: EcoIcon(path: IconPaths.clock),
                    title: "timeslot",
                    trailingText: "12/12/2012",
                  ),
                  SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
                  EcoTile(
                    leadingIcon: EcoIcon(path: IconPaths.note),
                    title: "note(optional)",
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    trailingText: note,
                    trailingIcon: IconButton(
                      constraints: BoxConstraints(),
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        CupertinoIcons.pencil,
                        size: 20.0,
                      ),
                      onPressed: () => showNoteDialog(
                        context,
                        onSubmit: (enteredText) {
                          setState(() {
                            note = enteredText; // Update the note and rebuild UI
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "If all the information is correct,\ntap next to confirm.",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontSize: (ThemeConstants.screenHeight * 1.3) / 100,
                          color: Theme.of(context).colorScheme.primary.withAlpha(150),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


void showNoteDialog(BuildContext context, {required void Function(String note) onSubmit}) {
  TextEditingController textController = TextEditingController();

  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: Text(
          "Enter Text",
          style: GoogleFonts.montserrat(),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 10),
            CupertinoTextField(
              controller: textController,
              placeholder: "Type here...",
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            ),
          ],
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context); // Close dialog
            },
            child: Text(
              "Cancel",
              style: GoogleFonts.montserrat(),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              String enteredText = textController.text.trim();
              Navigator.pop(context); // Close dialog
              onSubmit(enteredText); // Pass entered text to callback
            },
            child: Text(
              "Submit",
              style: GoogleFonts.montserrat(),
            ),
          ),
        ],
      );
    },
  );
}

import 'dart:io';
import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/home/homescreen.dart';
import 'package:eco_return/root/components/login/sign_in.dart';
import 'package:eco_return/root/components/payment_methods/payment_method_screen.dart';
import 'package:eco_return/root/components/payment_methods/providers/payment_method_states.dart';
import 'package:eco_return/root/widgets/date_picker_tile.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:eco_return/root/widgets/eco_list_tile.dart';
import 'package:eco_return/root/widgets/eco_textfield.dart';
import 'package:eco_return/root/widgets/payment_method_tile.dart';
import 'package:eco_return/root/widgets/profile_photo_widget.dart';
import 'package:eco_return/root/widgets/section_label.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _selectedImage;
   String primaryMethod = PaymentMethodStates.paymentMethods.isNotEmpty
      ? "****${PaymentMethodStates.paymentMethods[0].cardNumber.substring(PaymentMethodStates.paymentMethods[0].cardNumber.length - 4)}"
      : "None"; // Fallback value if the list is empty

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: ThemeConstants.screenHeight / 10),
              Center(
                child: ProfilePhoto(
                  selectedImage: _selectedImage,
                  onImageSelected: (image) {
                    setState(() {
                      _selectedImage = image;
                    });
                  },
                ),
              ),
              SizedBox(height: ThemeConstants.screenHeight * 4 / 100),
              Transform.translate(
                offset: Offset(-22, 0),
                child: SectionLabel(label: "Profile"),
              ),
              SizedBox(height: ThemeConstants.screenHeight * 2 / 100),

              /// Name Field
              EcoTextField(
                iconPath: IconPaths.smile,
                initialValue: "Josh",
                label: "Name",
                onChanged: (text) {},
              ),
              SizedBox(height: ThemeConstants.screenHeight * 2 / 100),

              /// Email Field
              EcoTextField(
                iconPath: IconPaths.email,
                initialValue: "",
                label: "Email",
                onChanged: (text) {},
              ),
              SizedBox(height: ThemeConstants.screenHeight * 2 / 100),

              /// Phone Field
              EcoTextField(
                iconPath: IconPaths.phone,
                initialValue: "",
                label: "Phone",
                onChanged: (text) {},
              ),
              SizedBox(height: ThemeConstants.screenHeight * 2 / 100),

              /// Address Field
              EcoTextField(
                iconPath: IconPaths.home,
                initialValue: "",
                label: "Address",
                onChanged: (text) {},
              ),
              SizedBox(height: ThemeConstants.screenHeight * 2 / 100),

              /// Date of Birth Field
              // EcoTextField(
              //   iconPath: IconPaths.cake,
              //   initialValue: "",
              //   label: "Date of Birth",
              //   onChanged: (text){},
              // ),
              DatePickerTile(
                initialDate: DateTime.now(),
                onDateSelected: (date) => print(date),
              ),
              SizedBox(height: ThemeConstants.screenHeight * 2 / 100),

              /// Payment Method Field
              // EcoTextField(
              //   iconPath: IconPaths.paymentMethod,
              //   initialValue: "",
              //   label: "Payment method",
              //   onChanged: (text){},
              // ),
              EcoListTile(
                ecoIconPath: IconPaths.paymentMethod,
                title: "Payment method",
                backgroundColor: Colors.transparent,
                borderColor: ThemeConstants.lightBorder,
                borderWidth: 2,
                trailingWidget: Text(
                  primaryMethod,
                  style: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 19, 33, 43),
                    fontWeight: FontWeight.w300,
                  ),
                ),
                onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => PaymentMethodScreen())),
              ),

              SizedBox(height: ThemeConstants.screenHeight * 4 / 100),
              Transform.translate(
                offset: Offset(-22, 0),
                child: SectionLabel(label: "Settings"),
              ),
              SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
              EcoListTile(
                ecoIconPath: IconPaths.smile,
                title: "Language",
                trailingWidget: Text(
                  "English",
                  style: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 19, 33, 43),
                  ),
                ),
              ),
              SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
              EcoListTile(
                ecoIconPath: IconPaths.clock,
                title: "Notifications",
                trailingWidget: Text(
                  "On",
                  style: GoogleFonts.montserrat(
                    color: const Color.fromARGB(255, 19, 33, 43),
                  ),
                ),
              ),
              SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
              EcoListTile(
                ecoIconPath: IconPaths.logout,
                title: "Logout",
                onTap: () => showLogoutDialog(context),
              ),
              SizedBox(height: ThemeConstants.screenHeight / 4),
            ],
          ),
        ),
      ),
    );
  }
}

void showLogoutDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        title: Text(
          "Logout",
          style: GoogleFonts.montserrat(),
        ),
        content: Text(
          "Are you sure you want to Logout?",
          style: GoogleFonts.montserrat(),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
            child: Text(
              "Cancel",
              style: GoogleFonts.montserrat(
                  fontSize: ThemeConstants.screenHeight * 1.7 / 100),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
              Navigator.pushAndRemoveUntil(
                context,
                // CupertinoPageRoute(builder: (_) => HomeScreenBottomNav()),
                CupertinoPageRoute(builder: (_) => SignInScreen()),
                (route) => false,
              );
              print("User logged out");
            },
            isDestructiveAction: true, // Highlights the button in red
            child: Text("Logout",
                style: GoogleFonts.montserrat(
                    fontSize: ThemeConstants.screenHeight * 1.7 / 100)),
          ),
        ],
      );
    },
  );
}

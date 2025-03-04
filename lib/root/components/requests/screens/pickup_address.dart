import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/requests/bottle_number/pickup_info_screen.dart';
import 'package:eco_return/root/components/requests/screens/location_screen.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:eco_return/root/widgets/eco_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PickupAddressComponent extends StatelessWidget {
  const PickupAddressComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: (ThemeConstants.screenHeight * 0) / 100),
              Text(
                "Enter your pickup address",
                style: GoogleFonts.montserrat(
                  fontSize: (ThemeConstants.screenHeight * 3) / 100,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: (ThemeConstants.screenHeight * 1) / 100),
              Text("This address will be used by our pickup agents to recieve the package from your location."),
              SizedBox(height: (ThemeConstants.screenHeight * 8) / 100),
            
              EcoTextField(initialValue: "", label: "address-1", iconPath: IconPaths.home, onChanged: (text) => print(text)),
              SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
        
              EcoTextField(initialValue: "", label: "address-2", iconPath: IconPaths.home2, onChanged: (text) => print(text)),
              SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
        
              EcoTextField(initialValue: "", label: "City", iconPath: IconPaths.home2, onChanged: (text) => print(text)),
              SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
      
              Spacer(),
      
        
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Can't find your address?\n Use live location-sharing instead",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                    fontSize: (ThemeConstants.screenHeight * 1.3) / 100,
                    color: Theme.of(context).colorScheme.primary.withAlpha(150),
                  ),
                ),
              ),
              SizedBox(height: (ThemeConstants.screenHeight * 1) / 100),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12), // Removes default padding
                  minimumSize: Size.zero,  // Allows the button to shrink to content size
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduces touch target padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.5), // Optional: Adjust border radius
                    side: BorderSide(width: 2, color: ThemeConstants.ecoGreen),
                  ),
                ),
                onPressed: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => LocationScreen(),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min, // Makes the Row as wide as its content
                  children: [
                    EcoIcon(path: IconPaths.stroke_location),
                    SizedBox(width: ThemeConstants.screenWidth * 3 / 100),
                    Text(
                      "Live location",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ), 
              SizedBox(height: (ThemeConstants.screenHeight * 3) / 100),               
            ],
          ),
        ),
      ),
    );
  }
}

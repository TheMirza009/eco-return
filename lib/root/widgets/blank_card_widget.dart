import 'package:dotted_border/dotted_border.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/payment_methods/add_payment_method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlankCard extends StatelessWidget {
  final Function()? onTap;
  const BlankCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
    child: DottedBorder(
      color:  Colors.grey,
      strokeWidth: 5,
      dashPattern: [16,8],
       borderType: BorderType.RRect,
       radius: Radius.circular(12),
       padding: EdgeInsets.all(6),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: ThemeConstants.screenHeight / 2.5,
          width: ThemeConstants.screenWidth / 1.9,
          decoration: BoxDecoration(
            color: Colors.grey[200], // Light grey color for the container
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add,
                size: 32,
                color: Colors.grey, // Matching the light grey color
              ),
              const SizedBox(height: 8), // Space between icon and text
              Text(
                "Add payment method",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
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
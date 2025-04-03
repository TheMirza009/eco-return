import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/menu_screens/withdraw_screens/withdraw_successful_screen.dart';
import 'package:eco_return/root/components/payment_methods/add_payment_method.dart';
import 'package:eco_return/root/data/models/payment_method_model.dart';
import 'package:eco_return/root/data/models/payment_type_model.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:eco_return/root/widgets/eco_list_tile.dart';
import 'package:eco_return/root/widgets/eco_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WithdrawConfirmationScreen extends StatelessWidget {
  final PaymentMethod paymentMethod;
  const WithdrawConfirmationScreen({super.key, required this.paymentMethod});

  @override
  Widget build(BuildContext context) {
   final textTheme = Theme.of(context).textTheme;

    return Scaffold(
     appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: EcoIcon(path: IconPaths.chevron, color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: (ThemeConstants.screenHeight * 4) / 100),
            Text(
              "Confirm Withdrawal?",
              style: textTheme.bodyLarge,
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 0.3) / 100),
            Text("Your selected amount will be withdrawn to this bank account."),
            SizedBox(height: (ThemeConstants.screenHeight * 5) / 100),
            EcoTile(title: "Bank Name", trailingText: "New York Bank"),
            SizedBox(height: (ThemeConstants.screenHeight * 1) / 100),
            EcoTile(
                title: "IBAN",
                trailingIcon: Text(
                  paymentMethod.cardNumber.replaceAllMapped(
                      RegExp(r".{4}"), (match) => "${match.group(0)} "),
                  style: GoogleFonts.montserrat(
                    letterSpacing: 5, // Increase the spacing between letters
                    fontSize: ThemeConstants.screenHeight * 1.7 / 100
                  ),
                )),
            Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
              child: 
                ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (_) => WithdrawSuccessfulScreen()
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  alignment: Alignment.centerLeft, // Align content to the left
                  padding: EdgeInsets.symmetric(horizontal: 16), // Add padding
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    EcoIcon(path: IconPaths.stroke_withdraw), // Leading icon
                    SizedBox(width: 8), // Spacing between icon and text
                    Expanded(
                      child: Align(
                        alignment: Alignment(-0.1 , 0),
                        child: Text("Withdraw",  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: ThemeConstants.screenHeight * 0.018)), // Centered text
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
}}
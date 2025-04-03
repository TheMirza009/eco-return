import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/menu_screens/withdraw_screens/withdraw_confirmation_screen.dart';
import 'package:eco_return/root/components/payment_methods/add_payment_method.dart';
import 'package:eco_return/root/components/payment_methods/payment_method_list.dart';
import 'package:eco_return/root/components/payment_methods/providers/payment_method_states.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseBankScreen extends StatelessWidget {
  const ChooseBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      resizeToAvoidBottomInset: false,
     appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: EcoIcon(path: IconPaths.chevron, color: Colors.black)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: (ThemeConstants.screenHeight * 2) / 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Choose Bank",
              style: textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 15, top: 5),
            child: Text(
                "Please enter your preferred payment method(s) which you want to use for withdrawal."),
          ),
          SizedBox(height: (ThemeConstants.screenHeight * 5) / 100),
          PaymentMethodList(
            paymentMethods: PaymentMethodStates.paymentMethods,
            onCardTapped: (card) => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => WithdrawConfirmationScreen(paymentMethod: card),
                  ),
                ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: 
              ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => AddPaymentMethodScreen(
                      onPaymentMethodAdded: (method) => print(method),
                    ),
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
                  EcoIcon(path: IconPaths.stroke_paymentMethod), // Leading icon
                  SizedBox(width: 8), // Spacing between icon and text
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Add Payment Method",  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500)), // Centered text
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

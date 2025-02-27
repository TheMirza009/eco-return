import 'package:eco_return/core/collections/dummy_payment_methods.dart';
import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/core/collections/illustration_paths.dart';
import 'package:eco_return/root/components/home/bottom_nav_screen.dart';
import 'package:eco_return/root/components/home/homescreen.dart';
import 'package:eco_return/root/components/login/signUp/sign_up.dart';
import 'package:eco_return/root/components/payment_methods/add_payment_method.dart';
import 'package:eco_return/root/components/payment_methods/payment_method_list.dart';
import 'package:eco_return/root/components/payment_methods/providers/payment_method_states.dart';
import 'package:eco_return/root/data/models/payment_method_model.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () => setState(() {
              PaymentMethodStates.paymentMethods.clear();
            }),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: EcoIcon(path: IconPaths.stroke_paymentMethod),
              onPressed: () => setState(() {
                print("Dummy methods added");
                PaymentMethodStates.paymentMethods = dummyPaymentMethods
                  .map((method) => PaymentMethod(
                        name: method.name,
                        cardNumber: method.cardNumber,
                        expiry: method.expiry,
                        cvv: method.cvv,
                        method: method.method,
                      ))
                  .toList();
                  print("Current Length: ${PaymentMethodStates.paymentMethods.length}");
              }),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: (ThemeConstants.screenHeight * 2) / 100),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              "Payment methods!",
              style: textTheme.bodyLarge,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 15),
            child: Text(
                "\nPlease enter your preferred payment method(s) which you want to use for transactions."),
          ),
          
          SizedBox(height: (ThemeConstants.screenHeight * 5) / 100),
          SizedBox(
            height: ThemeConstants.screenHeight / 2.0,
            child: PaymentMethodStates.paymentMethods.isEmpty 
            ? Padding(
              padding: const EdgeInsets.all(22.0),
              child: Image.asset(Illustrations.noPaymentMethod),
            ) 
            : PaymentMethodList(paymentMethods: PaymentMethodStates.paymentMethods),
          ),
          // SizedBox(height: (ThemeConstants.screenHeight * 7) / 100),
          
          
          // SizedBox(height: (ThemeConstants.screenHeight * 1.5) / 100),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Column(children: [
              ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  CupertinoPageRoute(builder: (_) => AddPaymentMethodScreen(
                    onPaymentMethodAdded: (method) => 
                    setState(() {
                    PaymentMethodStates.paymentMethods.add(method);
                    }),
                  )));
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
                      child: Text("Add payment method",  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500)), // Centered text
                    ),
                  ),
                ],
              ),
            ),
            
            ],),
          )
        ],
      ),
    );
  }
}

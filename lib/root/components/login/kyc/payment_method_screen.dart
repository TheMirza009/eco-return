import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/core/collections/illustration_paths.dart';
import 'package:eco_return/root/components/login/signUp/sign_up.dart';
import 'package:eco_return/root/components/payment_methods/add_payment_method.dart';
import 'package:eco_return/root/components/payment_methods/payment_method_list.dart';
import 'package:eco_return/root/data/models/payment_method_model.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PaymentMethodKYC extends StatefulWidget {
  const PaymentMethodKYC({super.key});

  @override
  State<PaymentMethodKYC> createState() => _PaymentMethodKYCState();
}

class _PaymentMethodKYCState extends State<PaymentMethodKYC> {
  String? paymentMethod;
  List<PaymentMethod> paymentMethods = [];
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
              "Payment methods!",
              style: textTheme.bodyLarge,
            ),
            Text("\nPlease enter your preferred payment method(s) which you want to use for transactions."),
            SizedBox(height: (ThemeConstants.screenHeight * 8) / 100),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(Illustrations.noPaymentMethod),
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 7) / 100),
            
            Center(child: TextButton(
              onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => PaymentMethodList(paymentMethods: paymentMethods,))),
              child: Text("Added payment methods: ${paymentMethods.length}", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),))),
            SizedBox(height: (ThemeConstants.screenHeight * 1.5) / 100),
            Expanded(child: SizedBox(),),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context, 
                  CupertinoPageRoute(builder: (_) => AddPaymentMethodScreen(
                    onPaymentMethodAdded: (method) => 
                    setState(() {
                    paymentMethods.add(method);
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
            SizedBox(height: (ThemeConstants.screenHeight * 1.5) / 100),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(
                onPressed: paymentMethod == null
                    ? () => Navigator.push(
                          context, CupertinoPageRoute(builder: (_) => SignUpMain()))
                    : null,
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>((states) => Colors.transparent ),
                  side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
                    if (paymentMethod == null) {
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

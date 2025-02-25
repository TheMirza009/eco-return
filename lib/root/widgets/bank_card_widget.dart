import 'package:eco_return/core/collections/illustration_paths.dart';
import 'package:eco_return/core/collections/logo_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/data/models/payment_method_model.dart';
import 'package:flutter/material.dart';

class BankCard extends StatelessWidget {
  final PaymentMethod card;
  const BankCard({super.key, required this.card});

  @override
  Widget build(BuildContext context) {
    String last4digits = card.cardNumber.substring(card.cardNumber.length - 4);
    return Container(
      height: ThemeConstants.screenHeight/3,
      width: ThemeConstants.screenWidth/1.8,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 21, 40, 49),
        borderRadius: BorderRadius.circular(12),
        ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("****$last4digits", 
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white), 
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(card.method.logo, width: ThemeConstants.screenWidth/8,),
                Text("Debit", 
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white), 
            ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

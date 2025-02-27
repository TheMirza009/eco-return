import 'package:eco_return/core/collections/card_styles.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/data/models/card_style.dart';
import 'package:eco_return/root/data/models/payment_method_model.dart';
import 'package:flutter/material.dart';

class BankCard extends StatelessWidget {
  final PaymentMethod card;
  final int number;
  const BankCard({
    super.key, 
    required this.card, 
    this.number = 0,
    });

  @override
  Widget build(BuildContext context) {

    // Cardstyles mapping
    final cardStylesMap = {
      0: CardStyles.darkBlue,
      1: CardStyles.lightWhite,
      2: CardStyles.ecoGreen,
      3: CardStyles.amberRed,
      4: CardStyles.birchWood,
      5: CardStyles.blackMetal,
      6: CardStyles.violetBlue,
      7: CardStyles.violetRed,
      8: CardStyles.velvetBlue,
      9: CardStyles.meteorBlack,
    };

    CardStyle cardStyle = cardStylesMap[number] ?? CardStyles.darkBlue;

    final logo = "Assets/icons/logos/${card.method.name}${cardStyle.extension}";
    String last4digits = card.cardNumber.substring(card.cardNumber.length - 4);
    return GestureDetector(
      onTap: () => print(logo),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
        child: Container(
          height: ThemeConstants.screenHeight/2.5,
          width: ThemeConstants.screenWidth/1.7,
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 21, 40, 49),
            borderRadius: BorderRadius.circular(12),
            gradient: RadialGradient(
              center: number == 9  ? Alignment(0.6, 0.9)  : Alignment.topLeft, // Moves the gradient center to the top left
              radius: number == 9 ? 3.0 : 2.5, // Adjust the radius as needed
              colors: cardStyle.gradient,
            ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 0).withAlpha(30), // White color with opacity for glow
                  spreadRadius: 3, // How much the shadow spreads
                  blurRadius: 8, // How blurred the shadow is
                  offset: const Offset(4, 4), // Shadow position (x, y)
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("****$last4digits", 
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cardStyle.textColor), 
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(logo, width: ThemeConstants.screenWidth/8,),
                    Text("Debit", 
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: cardStyle.textColor), 
                ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

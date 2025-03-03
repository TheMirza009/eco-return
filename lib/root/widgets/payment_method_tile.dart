import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/payment_methods/providers/payment_method_states.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PaymentMethodTile extends StatefulWidget {

  const PaymentMethodTile({
    Key? key,
  }) : super(key: key);

  @override
  _PaymentMethodTileState createState() => _PaymentMethodTileState();
}

class _PaymentMethodTileState extends State<PaymentMethodTile> {

  final primaryMethod = PaymentMethodStates.paymentMethods[0].cardNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: ThemeConstants.lightBorder,
            width: ThemeConstants.fieldBorderWidth),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SizedBox(width: 16), // Spacing
                EcoIcon(path: IconPaths.cake), // Leading icon
                SizedBox(width: 16), // Spacing
                Text(
                  "Date of Birth",
                  style: GoogleFonts.montserrat(
                      fontSize: ThemeConstants.getDynamicFontSize(15),
                      color: ThemeConstants.lightSubtitle,
                      fontWeight: FontWeight.w500), // Leading text
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  primaryMethod.isNotEmpty ? "****${primaryMethod.substring(primaryMethod.length - 4)}" : "No method selected.",
                  style: TextStyle(
                      fontSize: 14, color: Colors.grey), // Trailing text
                ),
                SizedBox(width: 2), // Spacing
                Icon(
                  CupertinoIcons.chevron_forward,
                  size: 24, // Appropriate icon size
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/menu_screens/withdraw_screens/choose_bank_screen.dart';
import 'package:eco_return/root/components/payment_methods/payment_method_screen.dart';
import 'package:eco_return/root/components/transactions/transactions_screen.dart';
import 'package:eco_return/root/data/enums/transaction_type.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:eco_return/root/widgets/see_all_header.dart';
import 'package:eco_return/root/widgets/transaction_tile.dart';
import 'package:eco_return/root/widgets/wallet_widgets/money_plate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () => Navigator.pop(context), icon: EcoIcon(path: IconPaths.chevron, color: Colors.black)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Static content above the list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: ThemeConstants.screenHeight * 8 / 100),
                Text(
                  "Account Wallet",
                  style: GoogleFonts.montserrat(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  "This is the current amount available for withdrawal along with your history.",
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                MoneyPlate(
                  currentBalance: "\$841.090",
                  totalReceived: "\$2000",
                  withdrawn: "\$1,159",
                ),
                Padding(
                    padding:const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                    child: SeeAllHeader(label: "Withdrawals", onSeeAllPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => TransactionsScreen(typeFilter: TransactionType.withdraw,))))),
                SizedBox(
                  child: TransactionTile(
                    bottles: 10,
                    amount: 100,
                    time: DateTime.now(),
                    transactionType: TransactionType.withdraw,
                  ),
              ),
              
              ],
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
                  CupertinoPageRoute(builder: (_) => ChooseBankScreen()));
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
                      child: Text("Withdraw",  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500)), // Centered text
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

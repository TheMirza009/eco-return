import 'dart:math';

import 'package:eco_return/core/collections/illustration_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/payment_methods/payment_method_screen.dart';
import 'package:eco_return/root/data/enums/transaction_type.dart';
import 'package:eco_return/root/widgets/transaction_chip.dart';
import 'package:eco_return/root/widgets/transaction_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {

  TransactionType? selectedType; // `null` means "All"

  // Dummy Transaction data
    final List<Map<String, dynamic>> dummyTransactions = List.generate(10, (index) {
      final random = Random();
      return {
        "bottles": random.nextInt(20) + 1, // Random bottles (1-20)
        "amount": random.nextInt(500), // Random amount (0-500)
        "time": DateTime.now().subtract(Duration(days: random.nextInt(10))), // Random recent time
        "type": random.nextInt(4) == 3 ? TransactionType.withdraw : TransactionType.receive, // Randomly choose TransactionType
      };
    });


  @override
  Widget build(BuildContext context) {

    // Filter transactions based on the selected type
    final filteredTransactions = selectedType == null
        ? dummyTransactions
        : dummyTransactions
            .where((transaction) => transaction['type'] == selectedType)
            .toList();


    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Static content above the list
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                Text(
                  "Transaction history",
                  style: GoogleFonts.montserrat(
                    fontSize: MediaQuery.of(context).size.height * 0.03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Text(
                  "This is a detailed list of all your transactions available in our records.",
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TransactionChip(
                      label: "All",
                      isSelected: selectedType == null,
                      onSelected: () => setState(() => selectedType = null),
                    ),
                    SizedBox(
                        width: ThemeConstants.screenWidth * 2 / 100), // Spacing
                    TransactionChip(
                      label: "Withdrawals",
                      isSelected: selectedType == TransactionType.withdraw,
                      onSelected: () => setState(
                          () => selectedType = TransactionType.withdraw),
                    ),
                    SizedBox(
                        width: ThemeConstants.screenWidth * 2 / 100), // Spacing
                    TransactionChip(
                      label: "Received",
                      isSelected: selectedType == TransactionType.receive,
                      onSelected: () => setState(
                          () => selectedType = TransactionType.receive),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // List of transactions
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: filteredTransactions.length + 1,
              itemBuilder: (context, index) {

                // Spacing at the end
                if (index == filteredTransactions.length) {
                  return SizedBox(height: ThemeConstants.screenHeight / 4);
                }

                final transaction = filteredTransactions[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: TransactionTile(
                    bottles: transaction["bottles"],
                    amount: transaction["amount"],
                    time: transaction["time"],
                    transactionType: transaction['type'],
                  ),
                );
              },
            ),
          ),

          // Button at the bottom
         
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ],
      ),
    );
  }
}


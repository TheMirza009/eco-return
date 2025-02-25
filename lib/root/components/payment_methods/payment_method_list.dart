import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/data/models/payment_method_model.dart';
import 'package:eco_return/root/widgets/bank_card_widget.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodList extends StatelessWidget {
  final List<PaymentMethod> paymentMethods;
  const PaymentMethodList({super.key, required this.paymentMethods});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: ThemeConstants.screenHeight / 7),
              Text("Added Payment Methods",
                  style: Theme.of(context).textTheme.bodyLarge),
              Expanded(
                child: ListView.builder(
                  itemCount: paymentMethods.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(paymentMethods[index].name),
                        subtitle: Text(paymentMethods[index].cardNumber),
                        leading: EcoIcon(path: IconPaths.stroke_paymentMethod),
                        trailing: Text(paymentMethods[index].cvv),
                      ),
                    );
                  },
                ),
              ),
              BankCard(card: paymentMethods[1])
            ],
          ),
        ),
      ),
    );
  }
}

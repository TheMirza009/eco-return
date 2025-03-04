import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/collections/illustration_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/payment_methods/payment_method_list.dart';
import 'package:eco_return/root/components/payment_methods/payment_method_screen.dart';
import 'package:eco_return/root/components/payment_methods/providers/payment_method_states.dart';
import 'package:eco_return/root/components/requests/request_pickup.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:eco_return/root/widgets/menu_tile.dart';
import 'package:eco_return/root/widgets/see_all_header.dart';
import 'package:eco_return/root/widgets/transaction_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Homescreen extends StatelessWidget {
  final void Function()? onRequestTapped;
  const Homescreen({super.key, this.onRequestTapped});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      // appBar: AppBar(backgroundColor: Colors.transparent, toolbarHeight: 0,),
      body: ListView(
        children: [
          Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: (ThemeConstants.screenHeight * 15) / 100),
              Text(
                "Welcome, Josh!",
                style: GoogleFonts.montserrat(fontSize: (ThemeConstants.screenHeight * 3) / 100, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: (ThemeConstants.screenHeight * 3) / 100),
              Row(
                children: [
                  MenuTile(
                    label: "Make a Request",
                    image: Illustrations.menuTile1,
                    width: ThemeConstants.screenWidth / 2.05,
                    onTap:  onRequestTapped ?? () => Future.delayed(Duration(milliseconds: 60), () => Navigator.push(context, CupertinoPageRoute(builder: (_) => RequestPickup()))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Column(
                      children: [
                        MenuTile(
                          label: "Wallet",
                          image: Illustrations.menuTile2,
                          width: ThemeConstants.screenWidth / 2.6,
                        ),
                        SizedBox(
                            height: (ThemeConstants.screenHeight * 1.55) / 100),
                        MenuTile(
                          label: "Stats",
                          image: Illustrations.menuTile3,
                          width: ThemeConstants.screenWidth / 2.6,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: (ThemeConstants.screenHeight * 2) / 100),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: SeeAllHeader(label: "Transactions", onSeeAllPressed: (){})
              ),
              SizedBox(
                child: TransactionTile(
                  bottles: 10,
                  amount: 100,
                  time: DateTime.now(),
                ),
              ),
              SizedBox(height: (ThemeConstants.screenHeight * 1) / 100),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                child: SeeAllHeader(label: "Payment method", onSeeAllPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => PaymentMethodScreen())))
              ),
              PaymentMethodList(paymentMethods: PaymentMethodStates.paymentMethods),
            SizedBox(height: ThemeConstants.screenHeight / 4,),
            ],
          ),
        ),],
      ),
    );
  }
}

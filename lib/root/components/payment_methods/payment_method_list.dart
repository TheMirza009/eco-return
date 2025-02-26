import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/payment_methods/add_payment_method.dart';
import 'package:eco_return/root/components/payment_methods/providers/payment_method_states.dart';
import 'package:eco_return/root/data/models/payment_method_model.dart';
import 'package:eco_return/root/widgets/bank_card_widget.dart';
import 'package:eco_return/root/widgets/blank_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PaymentMethodList extends StatefulWidget {
  final List<PaymentMethod> paymentMethods;
  const PaymentMethodList({super.key, required this.paymentMethods});

  @override
  State<PaymentMethodList> createState() => _PaymentMethodListState();
}

class _PaymentMethodListState extends State<PaymentMethodList> {
  int currentPage = 0;
  final PageController _pageController = PageController(
    viewportFraction: 1 / 1.7,
    initialPage: 0,
  );

  final colorMap = {
      0: ThemeConstants.ecoGrey,
      1: const Color.fromARGB(255, 205, 221, 238),
      2: const Color.fromARGB(255, 255, 149, 73),
      3: ThemeConstants.ecoGrey,
      4: ThemeConstants.ecoGrey,
      5: ThemeConstants.ecoGrey,
      6: ThemeConstants.ecoGrey,
      7: ThemeConstants.ecoGrey,
      8: ThemeConstants.ecoGrey,
      9: ThemeConstants.ecoGrey,
    };

  Color get indicatorColor => colorMap[currentPage] ?? colorMap[0]!;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: ThemeConstants.screenHeight / 2.5,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.paymentMethods.length + 1,
            padEnds: false, // Ensures left alignment
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              if (index == widget.paymentMethods.length && widget.paymentMethods.isNotEmpty) {
                return BlankCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (_) => AddPaymentMethodScreen(
                          onPaymentMethodAdded: (method) => setState(() {
                            PaymentMethodStates.paymentMethods.add(method);
                          }),
                        ),
                      ),
                    );
                  },
                );
              }
              return BankCard(
                card: widget.paymentMethods[index],
                number: index,
              );
            },
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 35.0, top: 15),
            child: SmoothPageIndicator(
              controller: _pageController, // Use the PageController
              count: widget.paymentMethods.length, // Include BlankCard in the count
              effect: ExpandingDotsEffect(
                activeDotColor: indicatorColor,
                dotColor: Colors.grey,
                dotHeight: 6.5,
                dotWidth: 20,
                spacing: 8,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

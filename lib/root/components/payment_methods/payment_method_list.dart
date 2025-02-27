import 'package:eco_return/core/collections/gradients.dart';
import 'package:eco_return/core/collections/illustration_paths.dart';
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
    viewportFraction: 1 / 1.52,
    initialPage: 0,
  );

  final colorMap = {
    0: ThemeConstants.ecoGrey,
    1: const Color.fromARGB(255, 205, 221, 238),
    2: Gradients.ecoGreen[0],
    3: Gradients.amberRed[0],
    4: Gradients.birchWood[0],
    5: Gradients.blackMetal[0],
    6: Gradients.violetBlue[0],
    7: Gradients.violetRed[0],
    8: Gradients.velvetBlue[0],
    9: Gradients.meteorBlack[1],
  };

  Color get indicatorColor => colorMap[currentPage] ?? colorMap[0]!;

  @override
  void didUpdateWidget(covariant PaymentMethodList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.paymentMethods.length != widget.paymentMethods.length) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _pageController.jumpToPage(0);
      });
      currentPage = 0;
    }
  }

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
          child: widget.paymentMethods.isEmpty
          ? Transform.translate(
            offset: Offset(0, -50),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Image.asset(Illustrations.noPaymentMethod, width: ThemeConstants.screenWidth),
            ),
          )
          : PageView.builder(
            controller: _pageController,
            itemCount: widget.paymentMethods.length + 1,
            padEnds: false, // Ensures left alignment
            onPageChanged: (index) {
              if (index < 0 || index > widget.paymentMethods.length) return;

              setState(() {
                currentPage = index;
              });

              if (index == 9) {
                Future.delayed(const Duration(seconds: 3), () {
                  if (mounted) {
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                });
              }
            },
            itemBuilder: (context, index) {
              // Handle empty payment methods list
              if (widget.paymentMethods.isEmpty) {
                return Image.asset(Illustrations.noPaymentMethod, width: ThemeConstants.screenWidth,);
              }

              // Blank Card render
              if (index == widget.paymentMethods.length &&  widget.paymentMethods.isNotEmpty) {
                // If 10 cards are already added, don't show this button.
                if (widget.paymentMethods.length == 10) {
                  return SizedBox.shrink();
                }

                // Blank Card
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

              // Actual Bank Cards list
              return BankCard(
                card: widget.paymentMethods[index],
                number: index,
              );
            },
          ),
        ),

        // Page indicator
        widget.paymentMethods.isEmpty 
        ? SizedBox.shrink() 
        : Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 35.0, top: 15),
            child: SmoothPageIndicator(
              controller: _pageController, // Use the PageController
              count:  widget.paymentMethods.length, // Include BlankCard in the count
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

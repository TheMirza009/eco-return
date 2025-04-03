import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/requests/bottle_number/bottle_number_component.dart';
import 'package:eco_return/root/components/requests/screens/pickup_address.dart';
import 'package:eco_return/root/components/requests/screens/pickup_summary.dart';
import 'package:eco_return/root/components/requests/screens/request_confirmed.dart';
import 'package:eco_return/root/components/requests/screens/timeslot_component.dart';
import 'package:eco_return/root/widgets/eco_animated_circle.dart';
import 'package:eco_return/root/widgets/eco_circle_icon.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wheel_slider/wheel_slider.dart';
import 'dart:math' as math;

class PickupInfoScreen extends StatefulWidget {
  const PickupInfoScreen({super.key});

  @override
  _PickupInfoScreenState createState() => _PickupInfoScreenState();
  
}

class _PickupInfoScreenState extends State<PickupInfoScreen> {
  final PageController _pageController = PageController();
  bool canPop = false;
  int _currentIndex = 0;
  late int currentPage;

  // Screens
  final List<Widget> screens = [
    BottleNumberComponent(),
    PickupAddressComponent(),
    TimeSlotComponent(),
    PickupSummaryComponent(),
  ];

  void _navigateToNextPage() {
    if (_currentIndex < screens.length - 1) {
      setState(() {
        _currentIndex++;
        currentPage = _currentIndex + 1; // Update AnimatedArc page value
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate to the confirmation screen when the user is on the last page
      Navigator.push(
        context,
        CupertinoPageRoute(builder: (_) => RequestConfirmedScreen()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    currentPage = _currentIndex; // Start AnimatedArc with _currentIndex
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          currentPage = _currentIndex + 1; // Update to _currentIndex + 1
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentIndex == 0, // Allow pop only when the index is zero
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (_currentIndex > 0) {
          // Decrement the index and update the page view
          setState(() {
            _currentIndex--;
            currentPage = _currentIndex + 1; // Update AnimatedArc page value
          });
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else if (didPop) {
          // Optional: handle the actual pop if it occurred
          print("Page popped");
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: ThemeConstants.screenHeight * 75 / 100,
              child: PageView(
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable manual swiping
                children: screens,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: AnimatedArc(
                page: currentPage, // Bind to currentPage for animation
                onPressed: _navigateToNextPage,
                size: ThemeConstants.screenHeight * 8 / 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/home/homescreen.dart';
import 'package:eco_return/root/components/profile/profile_screen.dart';
import 'package:eco_return/root/components/requests/request_pickup.dart';
import 'package:eco_return/root/components/transactions/transactions_screen.dart';
import 'package:eco_return/root/widgets/eco_bottom_tabs.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreenBottomNav extends StatefulWidget {
  const HomeScreenBottomNav({super.key});

  @override
  State<HomeScreenBottomNav> createState() => _HomeScreenBottomNavState();
}

class _HomeScreenBottomNavState extends State<HomeScreenBottomNav> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 150), // Animation duration
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: [

            /// Screens 
            /// 1. Homescreen
             Homescreen(
              onRequestTapped: () async {
                await Future.delayed(Duration(milliseconds: 80));
                setState(() {
                  _currentIndex = 1;
                });
              },
            ),
            /// 2. Pickup Request
            const RequestPickup(),

            /// 3. Transaction History
            const TransactionsScreen(),

            /// 4. Profile
            const ProfileScreen(),
          ]
          [_currentIndex],
          ),
          EcoBottomTabs(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ],
      ),
    );
  }
}

class TabScreen extends StatelessWidget {
  final String title;

  const TabScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          title,
          style: GoogleFonts.notoNastaliqUrdu(
            fontSize: 18,
            fontWeight: FontWeight.normal,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

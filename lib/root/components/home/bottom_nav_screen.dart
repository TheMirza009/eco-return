import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/home/homescreen.dart';
import 'package:eco_return/root/components/requests/request_pickup.dart';
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

  final List<Widget> _screens = [
    const Homescreen(),
    const RequestPickup(),
    const TabScreen(title: "Transactions"),
    const TabScreen(title: "Profile"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          [
            const Homescreen(),
            const RequestPickup(),
            const TabScreen(title: "Transactions"),
            const TabScreen(title: "Profile"),
          ]
          [_currentIndex],
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

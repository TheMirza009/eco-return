import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:eco_return/root/widgets/stat_widgets/stat_stack.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatScreen extends StatefulWidget {
  const StatScreen({super.key});

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  bool showTitle = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: AnimatedOpacity(
          opacity: showTitle ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 200),
          child: Text(
            "Stats",
            style: GoogleFonts.montserrat(
              fontSize: screenHeight * 0.03,
            ),
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: EcoIcon(path: IconPaths.chevron, color: Colors.black),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.axis == Axis.vertical) {
            final scrolled = scrollInfo.metrics.pixels > screenHeight * 0.1;
            if (scrolled != showTitle) {
              setState(() {
                showTitle = scrolled;
              });
            }
          }
          return false;
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          children: [
            SizedBox(height: ThemeConstants.screenHeight * 4 / 100),
            Text(
              "Stats",
              style: GoogleFonts.montserrat(
                fontSize: screenHeight * 0.03,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              "These are your statistics (all time) as available in our records.",
            ),
            SizedBox(height: screenHeight * 0.03),
            StatStack(),
          ],
        ),
      ),
    );
  }
}

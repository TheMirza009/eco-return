import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/widgets/eco_animated_circle.dart';
import 'package:eco_return/root/widgets/eco_circle_icon.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottleNumberScreen extends StatelessWidget {
  const BottleNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<int> bottlesNotifier = ValueNotifier<int>(1);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // SizedBox(height: (ThemeConstants.screenHeight * 15) / 100),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Number of bottles",
                style: GoogleFonts.montserrat(
                  fontSize: (ThemeConstants.screenHeight * 3) / 100,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    var bottles = bottlesNotifier.value;
                    bottlesNotifier.value = bottlesNotifier.value + 1;
                    print("Bottles: $bottles");
                  },
                  icon: Icon(
                    CupertinoIcons.chevron_up,
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: bottlesNotifier,
                  builder: (context, bottles, child) => Text(
                    "$bottles",
                    style: GoogleFonts.montserrat(
                      fontSize: ThemeConstants.screenHeight * 15 / 100,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Transform.translate(
                  offset: Offset(0, -20),
                  child: Text(
                    "bottles",
                    style: GoogleFonts.montserrat(
                      fontSize: ThemeConstants.screenHeight * 4 / 100,
                    ),
                  ),
                ),
                SizedBox(height: ThemeConstants.screenHeight * 5 / 100,),
                IconButton(
                  onPressed: () {
                    if (bottlesNotifier.value > 0) {
                      bottlesNotifier.value = bottlesNotifier.value - 1;
                    }
                    var bottles = bottlesNotifier.value;
                    print("Bottles: $bottles");
                  },
                  icon: Icon(
                    CupertinoIcons.chevron_down,
                  ),
                ),
              ],
            ),
            Text(
              "Move the slider to\nchange the number",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: (ThemeConstants.screenHeight * 1.5) / 100,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primary.withAlpha(100),
              ),
            ),
            // EcoIcon(path: IconPaths.next, size: (ThemeConstants.screenHeight * 8) / 100,),
            // EcoCircleIcon(path: IconPaths.next, size: (ThemeConstants.screenHeight * 8) / 100, ),
            AnimatedArc(size: (ThemeConstants.screenHeight * 8) / 100)
            // AnimatedArc(parameter: 1,),
          ],
        ),
      ),
    );
  }
}

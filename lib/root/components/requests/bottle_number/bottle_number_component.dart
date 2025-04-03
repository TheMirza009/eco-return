import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/widgets/eco_animated_circle.dart';
import 'package:eco_return/root/widgets/eco_circle_icon.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wheel_slider/wheel_slider.dart';
import 'dart:math' as math;

class BottleNumberComponent extends StatelessWidget {
  const BottleNumberComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final totalCount = 100;
    final initValue = 10;
    final ValueNotifier<int> bottlesNotifier = ValueNotifier<int>(1);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        children: [
          Align(
            alignment: Alignment(1.0, 0.3),
            child: SizedBox(
              width: ThemeConstants.screenWidth * 8 / 100,
              height: ThemeConstants.screenHeight * 70 / 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    CupertinoIcons.add,
                    weight: 30,
                    size: ThemeConstants.screenHeight * 3 / 100,
                  ),
                  WheelSlider(
                    horizontal: false,
                    isInfinite: true,
                    // interval: 5, // this field is used to show decimal/double values
                    perspective: 0.004,
                    verticalListHeight:  ThemeConstants.screenHeight * 64 / 100,
                    totalCount: totalCount,
                    initValue: initValue,
                    itemSize: 20.0,
                    lineColor: const Color.fromARGB(255, 109, 109, 109),
                    showPointer: false,
                    onValueChanged: (val) {
                      // int invertedValue = (totalCount - val - 1).toInt();
                      // bottlesNotifier.value = invertedValue == -1 ? 100 : invertedValue;
                      bottlesNotifier.value = val;
                      print(val);
                    },
                    hapticFeedbackType: HapticFeedbackType.vibrate,
                  ),
                  Icon(
                    CupertinoIcons.minus,
                    weight: 30,
                    size: ThemeConstants.screenHeight * 3 / 100,
                  ),
                ],
              ),
            ),
          ),
          Column(
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
              SizedBox(height: ThemeConstants.screenHeight * 5.5 / 100 ,),
              Column(
                children: [
                  IconButton(
                    onPressed: () {
                      var bottles = bottlesNotifier.value;
                      bottlesNotifier.value = bottlesNotifier.value + 1;
                      print("Bottles: $bottles");
                    },
                    icon: Transform.scale(
                      scaleY: 0.8,
                      child: Icon(
                        CupertinoIcons.chevron_up,
                        color:
                            Theme.of(context).colorScheme.primary.withAlpha(80),
                      ),
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
                  SizedBox(
                    height: ThemeConstants.screenHeight * 5 / 100,
                  ),
                  IconButton(
                    onPressed: () {
                      if (bottlesNotifier.value > 0) {
                        bottlesNotifier.value = bottlesNotifier.value - 1;
                      }
                      var bottles = bottlesNotifier.value;
                      print("Bottles: $bottles");
                    },
                    icon: Transform.scale(
                      scaleY: 0.8,
                      child: Icon(
                        CupertinoIcons.chevron_down,
                        color:
                            Theme.of(context).colorScheme.primary.withAlpha(80),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ThemeConstants.screenHeight * 5.5 / 100 ,),
              Text(
                "Move the slider to\nchange the number",
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: (ThemeConstants.screenHeight * 1.5) / 100,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primary.withAlpha(100),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

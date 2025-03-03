import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class EcoCircleIcon extends StatelessWidget {
  final String path;
  final double size;

  const EcoCircleIcon({
    super.key,
    required this.path,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: size,
          height: size,
          child: 
          CustomPaint(
            painter: CircularBorderPainter(),
          ),
        ),
        EcoIcon(
          path: path,
          size: size * 0.8, // Adjust size to fit inside the circle
        ),
      ],
    );
  }
}

class CircularBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 3.0; // Width of the circle border
    final Rect rect = Offset.zero & size;

    // Grey paint for 3/4th of the circle
    final Paint greyPaint = Paint()
      ..color = const Color.fromARGB(41, 48, 185, 176)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    // EcoGreen paint for 1/4th of the circle
    final Paint greenPaint = Paint()
      ..color = ThemeConstants.ecoGreen // EcoGreen
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;

    // Draw the grey arc (3/4th of the circle)
    canvas.drawArc(rect, -math.pi / 2, math.pi * 2, false, greyPaint);


    // Draw the green arc (1/4th of the circle)
    canvas.drawArc(rect, -math.pi / 2, math.pi / 2, false, greenPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

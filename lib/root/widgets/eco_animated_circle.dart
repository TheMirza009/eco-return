import 'dart:math' as math;
import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/requests/bottle_number/pickup_info_screen.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedArc extends StatefulWidget {
  final int page;
  final double size;
  final Widget navigateTo;
  final void Function()? onPressed;
  const AnimatedArc({
      super.key,
      this.page = 0,
      required this.size,
      this.navigateTo = const PickupInfoScreen(),
      this.onPressed,
      });

  @override
  _AnimatedArcState createState() => _AnimatedArcState();
}

class _AnimatedArcState extends State<AnimatedArc> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _updateAnimation(widget.page, widget.page); // Initialize to the current page's angle
  }

  @override
  void didUpdateWidget(covariant AnimatedArc oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.page != oldWidget.page) {
      _updateAnimation(oldWidget.page, widget.page); // Update animation based on new and old values
      _controller.forward(from: 0.0);
    }
  }

  void _updateAnimation(int startPage, int endPage) {
    final List<double> angleSteps = [
      0.0,
      math.pi / 2,
      math.pi,
      math.pi * 1.5,
      math.pi * 2,
    ];

    // Define the animation with start and end values
    _animation = Tween<double>(
      begin: angleSteps[startPage],
      end: angleSteps[endPage],
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(widget.size, widget.size),
            painter: ArcPainter(animation: _animation),
          ),
          EcoIcon(
            path: IconPaths.next,
            size: widget.size * 0.8, // Icon inside the circle
          ),
        ],
      ),
    );
  }
}


class ArcPainter extends CustomPainter {
  final Animation<double> animation;
  ArcPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromCircle(center: Offset(size.width / 2, size.height / 2), radius: size.width / 2);

    // Draw the background grey circle (full circle)
    final greyPaint = Paint()
      ..color = const Color.fromARGB(52, 48, 185, 176)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -math.pi / 2, math.pi * 2, false, greyPaint);

    // Draw the green arc using the animated sweep angle.
    final greenPaint = Paint()
      ..color = ThemeConstants.ecoGreen
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // The green arc always starts at -π/2. Its sweep is animation.value.
    canvas.drawArc(rect, -math.pi / 2, animation.value, false, greenPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

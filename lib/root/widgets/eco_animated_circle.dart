import 'dart:math' as math;
import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/material.dart';

class AnimatedArc extends StatefulWidget {
  final double size;

  const AnimatedArc({Key? key, required this.size}) : super(key: key);

  @override
  _AnimatedArcState createState() => _AnimatedArcState();
}

class _AnimatedArcState extends State<AnimatedArc> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _parameter = 1; // State variable to track the current parameter
  double _currentAngle = 0.0; // Start from 0
  double _endAngle = math.pi / 2; // First quarter-circle

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    // Initialize the animation with zero starting angle
    _setAnimationRange();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && _parameter < 4) {
        setState(() {
          _currentAngle = _endAngle; // Update starting point to the last end point
          _parameter++;
          _setAnimationRange();
        });
      }
    });
  }

  void _setAnimationRange() {
    // Determine the next angle based on the parameter
    switch (_parameter) {
      case 1:
        _endAngle = math.pi / 2; // Quarter-circle
        break;
      case 2:
        _endAngle = math.pi; // Half-circle
        break;
      case 3:
        _endAngle = math.pi * 1.5; // 3/4 circle
        break;
      case 4:
        _endAngle = math.pi * 2; // Full circle
        break;
      default:
        _endAngle = math.pi / 2; // Default to quarter-circle
    }

    // Update the animation range from _currentAngle to _endAngle
    _animation = Tween<double>(begin: _currentAngle, end: _endAngle).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _onTap() {
    if (_parameter < 4) {
      _controller.forward(from: 0.0); // Start animation
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: CustomPaint(
              size: Size(widget.size, widget.size), // Fixed size for the circle
              painter: ArcPainter(animation: _animation),
            ),
          ),
          EcoIcon(
            path: IconPaths.next,
            size: widget.size * 0.8, // Adjust size to fit inside the circle
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

    // Grey arc (full circle)
    final greyPaint = Paint()
      ..color = const Color.fromARGB(52, 48, 185, 176)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -math.pi / 2, math.pi * 2, false, greyPaint);

    // Green arc (animated portion)
    final greenPaint = Paint()
      ..color = ThemeConstants.ecoGreen
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(rect, -math.pi / 2, animation.value, false, greenPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint on animation updates
  }
}

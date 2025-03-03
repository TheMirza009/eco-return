import 'dart:async';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExitToast extends StatefulWidget {
  final String message;
  final Duration duration;
  final TextStyle textStyle;
  final Color backgroundColor;
  final double borderRadius;

  const ExitToast({
    Key? key,
    this.message = "Press back again to exit",
    this.duration = const Duration(seconds: 2),
    this.textStyle = const TextStyle(fontSize: 14, color: Colors.white),
    this.backgroundColor = const Color(0xAA000000),
    this.borderRadius = 20,
  }) : super(key: key);

  @override
  _ExitToastState createState() => _ExitToastState();
}

class _ExitToastState extends State<ExitToast> with SingleTickerProviderStateMixin {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _showToast();
  }

  void _showToast() {
    setState(() {
      _visible = true;
    });

    Timer(widget.duration, () {
      setState(() {
        _visible = false;
      });

      // Remove the toast after the fade-out completes
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) Navigator.of(context).pop();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _visible ? 1.0 : 0.0,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: ThemeConstants.screenHeight / 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(widget.borderRadius),
              ),
              child: Text(
                widget.message,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(fontSize: 14, color: Colors.white),
                // style: widget.textStyle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

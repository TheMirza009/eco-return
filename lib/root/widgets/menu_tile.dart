import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MenuTile extends StatefulWidget {
  final String image;
  final double width;
  final String? label;
  final VoidCallback? onTap;

  const MenuTile({
    Key? key,
    required this.image,
    required this.width,
    this.label,
    this.onTap,
  }) : super(key: key);

  @override
  State<MenuTile> createState() => _MenuTileState();
}

class _MenuTileState extends State<MenuTile> {
  bool isClicked = false;

  void handleTap() {
    setState(() {
      isClicked = true;
    });

    Future.delayed(const Duration(milliseconds: 50), () {
      setState(() {
        isClicked = false;
      });
    });

    // Call the custom onTap function if provided
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 50),
        curve: Curves.easeIn,
        opacity: isClicked ? 0.5 : 1.0,
        child: Stack(
          children: [
            Image.asset(
              widget.image,
              width: widget.width,
              fit: BoxFit.cover,
            ),
            if (widget.label != null)
              Positioned(
                top: ThemeConstants.screenHeight * 1.5 / 100,
                left: ThemeConstants.screenHeight * 1.8 / 100,
                child: Text(
                  widget.label!,
                  style: GoogleFonts.montserrat(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w500,
                    fontSize:  ThemeConstants.screenWidth * 4.6 / 100,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

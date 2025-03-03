import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EcoListTile extends StatefulWidget {
  final String ecoIconPath;
  final String title;
  final String? subtitle;
  final Widget? trailingWidget;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final VoidCallback? onTap;

  const EcoListTile({
    Key? key,
    required this.ecoIconPath,
    required this.title,
    this.subtitle,
    this.trailingWidget,
    this.backgroundColor = const Color.fromARGB(255, 235, 240, 243),
    this.borderColor =  const Color.fromARGB(255, 235, 240, 243),
    this.borderWidth = 1.0,
    this.onTap,
  }) : super(key: key);

  @override
  _EcoListTileState createState() => _EcoListTileState();
}

class _EcoListTileState extends State<EcoListTile> {
  double _opacity = 1.0;

  void _handleTap() {
    setState(() {
      _opacity = 0.2; // Fade effect
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1.0; // Restore opacity
      });

      if (widget.onTap != null) {
        widget.onTap!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: _opacity,
        child: Container(
          height: ThemeConstants.screenHeight * 6.8 / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: widget.borderColor, width: widget.borderWidth),
            color: widget.backgroundColor,
          ),
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const SizedBox(width: 5),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: ThemeConstants.screenWidth * 5 / 100,
                        width: ThemeConstants.screenWidth * 5 / 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                      EcoIcon(path: widget.ecoIconPath),
                    ],
                  ),
                  const SizedBox(width: 16),
                  Text(
                    widget.title,
                    style: GoogleFonts.montserrat(
                      color: const Color.fromARGB(255, 14, 25, 32),
                      fontWeight: FontWeight.w500,
                      fontSize: ThemeConstants.screenHeight * 1.9 / 100,
                    ),
                  ),
                ],
              ),
              widget.trailingWidget != null
                  ? Row(
                      children: [
                        widget.trailingWidget!,
                        SizedBox(width: ThemeConstants.screenHeight * 1.5 / 100),
                        const Icon(Icons.chevron_right),
                      ],
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}

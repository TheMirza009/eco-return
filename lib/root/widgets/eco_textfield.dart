import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EcoTextField extends StatelessWidget {
  final String initialValue;
  final String label;
  final String iconPath;
  final TextInputType keyboardType;
  final ValueChanged<String> onChanged;
  final FocusNode? focusNode;

  const EcoTextField({
    Key? key,
    required this.initialValue,
    required this.label,
    required this.iconPath,
    this.keyboardType = TextInputType.text,
    required this.onChanged,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController(text: initialValue);

    return TextField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: GoogleFonts.montserrat(
        fontSize: ThemeConstants.getDynamicFontSize(15),
        color: ThemeConstants.lightSubtitle,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: SvgPicture.asset(
            iconPath,
            height: ThemeConstants.screenHeight / 42,
            colorFilter: ColorFilter.mode(
              ThemeConstants.ecoGreen,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}

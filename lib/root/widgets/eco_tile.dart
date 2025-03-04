import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class EcoTile extends StatelessWidget {
  final Widget? leadingIcon;
  final String? title;
  final Widget? trailingIcon;
  final String? trailingText;
  final EdgeInsetsGeometry padding;

  const EcoTile({
    Key? key,
    this.leadingIcon,
    this.title,
    this.trailingIcon,
    this.trailingText,
    this.padding = const EdgeInsets.symmetric(vertical: 15, horizontal: 18),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ThemeConstants.lightBorder, width: 2),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (leadingIcon != null) ...[
            leadingIcon!,
            const SizedBox(width: 15), // Space between leading icon and title
          ],
          if (title != null) ...[
            Expanded(
              child: Text(
                title!,
                style: GoogleFonts.montserrat(fontWeight: FontWeight.w500, fontSize: ThemeConstants.screenHeight * 2 / 100),
              ),
            ),
          ],
          if (trailingText != null || trailingIcon != null) ...[
            Row(
              children: [
                if (trailingText != null)
                  Text(
                    trailingText!,
                    style: GoogleFonts.montserrat(
                        color: const Color.fromARGB(193, 0, 0, 0),
                        fontSize: ThemeConstants.screenHeight * 1.3 / 100,),

                  ),
                if (trailingText != null && trailingIcon != null)
                title == "note(optional)" ? const SizedBox.shrink() : const SizedBox( width: 8), // Space between trailing text and icon
                if (trailingIcon != null) trailingIcon!,
              ],
            ),
          ],
        ],
      ),
    );
  }
}

import 'dart:ui';

class CardStyle {

  final int number;
  final Color textColor;
  final List<Color> gradient;
  final String extension;

  const CardStyle({
    required this.number,
    required this.textColor,
    required this.gradient,
    this.extension = "_light",
  });

}

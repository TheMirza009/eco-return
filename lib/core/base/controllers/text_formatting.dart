import 'package:flutter/services.dart';

class TextFormatting {
  
    // Format Card Number
    static final formatCardNumber = TextInputFormatter.withFunction((oldValue, newValue) {
      String digits = newValue.text.replaceAll(RegExp(r'\D'), ''); // Remove all non-digit characters
      String formatted = digits.replaceAllMapped(RegExp(r'.{1,4}'), (match) => '${match.group(0)} ').trim();  // Add spaces after every 4 digits
      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });

    // Format Expiry
    static final simpleExpiryFormatter = TextInputFormatter.withFunction((oldValue, newValue) {
      // Remove non-digits
      String digits = newValue.text.replaceAll(RegExp(r'\D'), '');
      if (digits.length > 4) digits = digits.substring(0, 4);

      // Ensure months do not exceed 12
      if (digits.length >= 2) {
        int month = int.parse(digits.substring(0, 2));
        if (month > 12) {
          digits = '12${digits.substring(2)}'; // Replace invalid month with 12
        }
      }

      // Insert slash after two digits if applicable
      String formatted = digits.length >= 3
          ? '${digits.substring(0, 2)}/${digits.substring(2)}'
          : digits;

      return TextEditingValue(
        text: formatted,
        selection: TextSelection.collapsed(offset: formatted.length),
      );
    });

}
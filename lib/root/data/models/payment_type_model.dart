import 'package:eco_return/core/collections/logo_paths.dart';

class PaymentType {
  final String name;
  final String logo;

  PaymentType._internal(this.name, this.logo);

  static final _methods = {
    0: PaymentType._internal("visa", Logos.visa),
    1: PaymentType._internal("mastercard", Logos.mastercard_dark),
    2: PaymentType._internal("paypal", Logos.paypal),
  };

  factory PaymentType(int selection) {
    if (!_methods.containsKey(selection)) {
      throw ArgumentError("Invalid selection");
    }
    return _methods[selection]!;
  }
}

import 'package:eco_return/root/data/models/payment_type_model.dart';

class PaymentMethod {
  final String name;
  final String cardNumber;
  final String expiry;
  final String cvv;
  final PaymentType method;

  const PaymentMethod({
    required this.name,
    required this.cardNumber,
    required this.expiry,
    required this.cvv,
    required this.method,
  });

  // Factory method to create an instance from JSON
  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      name: json['name'] as String,
      cardNumber: json['cardNumber'] as String,
      expiry: json['expiry'] as String,
      cvv: json['cvv'] as String,
      method: json['method'] as PaymentType,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'cardNumber': cardNumber,
      'expiry': expiry,
      'cvv': cvv,
      'method': method,
    };
  }
}
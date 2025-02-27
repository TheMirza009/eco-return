import 'package:eco_return/root/data/models/payment_method_model.dart';
import 'package:eco_return/root/data/models/payment_type_model.dart';

List<PaymentMethod> dummyPaymentMethods = [
  PaymentMethod(
    name: "John Doe",
    cardNumber: "4111111111111111",
    expiry: "12/24",
    cvv: "123",
    method: PaymentType(1), // MasterCard
  ),
  PaymentMethod(
    name: "Jane Smith",
    cardNumber: "5500000000000004",
    expiry: "01/25",
    cvv: "456",
    method: PaymentType(2), // Mastercard
  ),
  PaymentMethod(
    name: "Alice Johnson",
    cardNumber: "371449635398431",
    expiry: "06/23",
    cvv: "789",
    method: PaymentType(0), // Visa
  ),
  PaymentMethod(
    name: "Bob Williams",
    cardNumber: "6011000990139424",
    expiry: "03/26",
    cvv: "234",
    method: PaymentType(1), // Mastercard
  ),
  PaymentMethod(
    name: "Charlie Brown",
    cardNumber: "4000001234567899",
    expiry: "09/27",
    cvv: "567",
    method: PaymentType(2), // Visa
  ),
  PaymentMethod(
    name: "Dave Adams",
    cardNumber: "4242424242424242",
    expiry: "05/22",
    cvv: "890",
    method: PaymentType(2), // PayPal
  ),
  PaymentMethod(
    name: "Eve Cooper",
    cardNumber: "378282246310005",
    expiry: "02/24",
    cvv: "321",
    method: PaymentType(0), // Visa
  ),
  PaymentMethod(
    name: "Fiona Harper",
    cardNumber: "5105105105105100",
    expiry: "08/23",
    cvv: "654",
    method: PaymentType(1), // Mastercard
  ),
  PaymentMethod(
    name: "George King",
    cardNumber: "6011111111111117",
    expiry: "07/28",
    cvv: "987",
    method: PaymentType(2), // PayPal
  ),
  PaymentMethod(
    name: "Hannah Scott",
    cardNumber: "3530111333300000",
    expiry: "11/22",
    cvv: "123",
    method: PaymentType(1), // Mastercard
  ),
];
import 'package:eco_return/core/base/controllers/text_formatting.dart';
import 'package:eco_return/core/collections/logo_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/collections/illustration_paths.dart';
import 'package:eco_return/root/components/login/signUp/sign_up.dart';
import 'package:eco_return/root/data/models/payment_method_model.dart';
import 'package:eco_return/root/data/models/payment_type_model.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:eco_return/root/widgets/payment_type_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AddPaymentMethodScreen extends StatefulWidget {
  final void Function(PaymentMethod alarm) onPaymentMethodAdded;
  const AddPaymentMethodScreen({super.key, required this.onPaymentMethodAdded});

  @override
  State<AddPaymentMethodScreen> createState() => _AddPaymentMethodScreenState();
}

class _AddPaymentMethodScreenState extends State<AddPaymentMethodScreen> {

    // Declarations
    bool complete = false;
    int selectedType = -1;
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController cardNumberController = TextEditingController();
    final TextEditingController expiryController = TextEditingController();
    final TextEditingController cvvController = TextEditingController();
    final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
    final ValueNotifier<bool> isValid = ValueNotifier<bool>(false);

void _updateValidationState() {
  isValid.value = _formKey.currentState?.validate() ?? false;
}

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(
          Duration(milliseconds: 700), () => focusNodes[0].requestFocus());
    });

    // Tick Icon Listeners
    // nameController.addListener(() => _updateValidationState());
    // cardNumberController.addListener(() => _updateValidationState());
    // expiryController.addListener(() => _updateValidationState());
    // cvvController.addListener(() => _updateValidationState());

    // isValid.addListener(() {
    //   if (complete) {setState(() {});}
    // });
  }

  @override
  Widget build(BuildContext context) {

    if (nameController.text.isNotEmpty
        && cardNumberController.text.isNotEmpty 
        && expiryController.text.isNotEmpty 
        && cvvController.text.isNotEmpty
        && selectedType != -1) {
          complete = true;
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () => print("Scan"), 
              icon: EcoIcon(path: IconPaths.stroke_scan, size: ThemeConstants.iconSize + 3)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: (ThemeConstants.screenHeight * 7) / 100),
              Text("Add payment method", style: Theme.of(context).textTheme.bodyLarge),
              const Text(
                "\nPlease confirm the information you enter before it can be sent to our agents.",
              ),
              SizedBox(height: (ThemeConstants.screenHeight * 7) / 100),
          
             /// Name Field
            TextFormField(
              controller: nameController,
              focusNode: focusNodes[0],
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                label: Text("Name"),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              style: GoogleFonts.montserrat(
                fontSize: ThemeConstants.getDynamicFontSize(15),
                color: ThemeConstants.lightSubtitle,
                fontWeight: FontWeight.w500,
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Name cannot be empty.";
                } else if (value.trim().length < 3) {
                  return "Name must be atleast 3 charaters long.";
                }
                return null;
              },
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 2.5) / 100),
          
              /// Card Number Field
              TextFormField(
                controller: cardNumberController,
                focusNode: focusNodes[1],
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(19), // 16 digits + 3 spaces.
                  TextFormatting.formatCardNumber,
                ],
                decoration: InputDecoration(
                  label: Text("Card number"),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                ),
                style: GoogleFonts.montserrat(
                  fontSize: ThemeConstants.getDynamicFontSize(15),
                  color: ThemeConstants.lightSubtitle,
                  fontWeight: FontWeight.w500,
                ),
                validator: (value) {
                  final cleanedValue = value?.replaceAll(RegExp(r'\s+'), '') ?? '';
                  if (cleanedValue.isEmpty) {
                    return "Card number cannot be empty.";
                  }
                  if (cleanedValue.length < 16) {
                    return "Card number must be at least 16 digits.";
                  }
                  return null;
                },
              ),
              SizedBox(height: (ThemeConstants.screenHeight * 2.5) / 100),
          
              /// Two-Field ROW
              Row(
                children: [
                  Expanded(
          
                    /// Expiry Field (Format: MM/YY)
                    child: TextFormField(
                    controller: expiryController,
                    focusNode: focusNodes[2],
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(5), // MM/YY format.
                      TextFormatting.simpleExpiryFormatter,
                    ],
                    decoration: InputDecoration(
                      label: Text("Expiry"),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    style: GoogleFonts.montserrat(
                      fontSize: ThemeConstants.getDynamicFontSize(15),
                      color: ThemeConstants.lightSubtitle,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      final cleanedValue = value?.replaceAll(RegExp(r'\D'), '') ?? '';
                      if (cleanedValue.isEmpty) {
                        return "Expiry cannot be empty.";
                      }
                      if (cleanedValue.length < 4) {
                        return "Incorrect format\n(MM/YY).";
                      }
                      return null;
                    },
                  ),
                  ),
          
                  SizedBox(width: (ThemeConstants.screenHeight * 2.5) / 100),
                  Expanded(
          
                    /// CVV Field
                    child: TextFormField(
                    controller: cvvController,
                    focusNode: focusNodes[3],
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4), // Maximum 4 digits.
                    ],
                    decoration: InputDecoration(
                      label: Text("CVV"),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    ),
                    style: GoogleFonts.montserrat(
                      fontSize: ThemeConstants.getDynamicFontSize(15),
                      color: ThemeConstants.lightSubtitle,
                      fontWeight: FontWeight.w500,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Cannot be empty.";
                      }
                      if (value.length < 3) {
                        return "3 digits minimum.";
                      }
                      return null;
                    },
                  ),
                  ),
                ],
              ),
              SizedBox(height: (ThemeConstants.screenHeight * 3) / 100),
              const Text("\nAccepted methods"),
              SizedBox(height: (ThemeConstants.screenHeight * 3) / 100),
          
              /// Payment Type Row
              Row(
                children: [
                  PaymentTypeWidget(
                    logoPath: Logos.visa,
                    selected: selectedType == 0,
                    onTap: () => setState(() { selectedType = 0; }),
                  ),
                  const SizedBox(width: 15),
                  PaymentTypeWidget(
                    logoPath: Logos.mastercard,
                    selected: selectedType == 1,
                    onTap: () => setState(() { selectedType = 1; }),
                  ),
                  const SizedBox(width: 15),
                  PaymentTypeWidget(
                    logoPath: Logos.paypal,
                    selected: selectedType == 2,
                    onTap: () => setState(() { selectedType = 2; }),
                  ),
                ],
              ),
              Expanded(child: SizedBox.shrink()),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    _updateValidationState();

                    // Trigger form validation and display error messages
                    if (_formKey.currentState?.validate() ?? false) {
                      PaymentMethod newMethod = PaymentMethod(
                        name: nameController.text,
                        cardNumber: cardNumberController.text.replaceAll(" ", ""),
                        expiry: expiryController.text,
                        cvv: cvvController.text,
                        method: PaymentType(selectedType),
                      );
                      widget.onPaymentMethodAdded(newMethod);

                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(content: Text("Form submitted successfully!")),
                      // );
                      Future.delayed(Duration(milliseconds: 500), () => Navigator.pop(context));
                      
                    } else {
                      // Ensure complete gets updated for enabling/disabling the button
                      setState(() {
                        complete = false;
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.resolveWith<Color>((states) => Colors.transparent ),
                    side: WidgetStateProperty.resolveWith<BorderSide?>((states) {
                      if (!complete) {
                        return const BorderSide(
                            color: Colors.grey, width: 1.5); // Grey border
                      }
                      return null; // Default style
                    }),
                  ),
                  child: // Update your button widget
                  ValueListenableBuilder<bool>(
                    valueListenable: isValid,
                    builder: (context, valid, _) {
                      return valid
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Next",
                                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                                ),
                                Icon(
                                  CupertinoIcons.check_mark,
                                  color: ThemeConstants.ecoGreen,
                                  weight: 1000,
                                ),
                              ],
                            )
                          : Text(
                              "Next",
                              style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

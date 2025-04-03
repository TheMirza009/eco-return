import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/login/kyc/name_screen.dart';
import 'package:eco_return/root/widgets/otp_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PinScreen extends StatelessWidget {
  const PinScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a list of controllers for each OTP field
    final List<TextEditingController> controllers = List.generate(4, (index) => TextEditingController());

    // ValueNotifier to track if all fields are filled
    final ValueNotifier<bool> isCompleteNotifier = ValueNotifier(false);
    String? pin;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: (ThemeConstants.screenHeight * 7) / 100),
            Text("Enter Verification Pin", style: Theme.of(context).textTheme.bodyLarge),
            const Text(
              "\nWe have sent you a verification pin on your email and phone. Please enter it below for verification.",
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 15) / 100),
            OTPField(
              controllers: controllers,
              isCompleteNotifier: isCompleteNotifier,
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("didn't receive the code?"),
                  GestureDetector(
                    onTap: () => print("REGISTER!"),
                    child: Text(
                      " Resend",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        color: ThemeConstants.ecoGreen,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ValueListenableBuilder<bool>(
                valueListenable: isCompleteNotifier,
                builder: (context, isComplete, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.transparent,
                      side: BorderSide(
                        width: 3,
                        color: isComplete
                            ? ThemeConstants.ecoGreen
                            : Colors.grey,
                      ),
                    ),
                    onPressed: isComplete
                        ? () {
                            // Your verify logic here
                            Navigator.push(context, CupertinoPageRoute(builder: (_) => NameScreen()));
                            print("Verification Successful");
                            pin = controllers.map((controller) => controller.text).join('');
                            print("PIN: $pin");
                          }
                        : null,
                    child: Text(
                      "Verify",
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

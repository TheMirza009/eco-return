import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/home/bottom_nav_screen.dart';
import 'package:eco_return/root/components/login/kyc/payment_method_screen_kyc.dart';
import 'package:eco_return/root/components/login/sign_in.dart';
import 'package:eco_return/root/widgets/exit_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeConstants.screenWidth = MediaQuery.sizeOf(context).width;
    ThemeConstants.screenHeight = MediaQuery.sizeOf(context).height;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Set your desired color
        statusBarIconBrightness: Brightness.light, // Set the icon color (light/dark)
      ),
    );

    return MaterialApp(
      title: 'Eco-Return',
      theme: ThemeConstants.lightTheme,
      home: DoubleBack(
          message: "",
          background: Colors.transparent,
          onFirstBackPress: (context) => showDialog(
                context: context,
                barrierColor: Colors.transparent,
                barrierDismissible: false,
                builder: (BuildContext context) =>  const ExitToast(),
              ),
          child: const HomeScreenBottomNav()),
      // home: const SignInScreen(),
      // home: const PaymentMethodKYC(),
    );
  }
}

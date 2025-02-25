import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/login/sign_in.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeConstants.screenWidth = MediaQuery.sizeOf(context).width;
    ThemeConstants.screenHeight = MediaQuery.sizeOf(context).height;
    return MaterialApp(
      title: 'Eco-Return',
      theme: ThemeConstants.lightTheme,
      home: const SignInScreen(),
    );
  }
}
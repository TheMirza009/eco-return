import 'package:eco_return/core/utilitis/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/login/signUp/pin_screen.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpMain extends StatelessWidget {
  const SignUpMain({super.key});

  @override
  Widget build(BuildContext context) {

    final TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: (ThemeConstants.screenHeight * 7) / 100),
            Text("Create new account", style: textTheme.bodyLarge),
            Text("\nEnter your email address and phone number below and choose a strong password. These will be used to contact you."),
            SizedBox(height: (ThemeConstants.screenHeight * 8) / 100),
            TextField(
              style: GoogleFonts.montserrat(fontSize: ThemeConstants.getDynamicFontSize(15), color: ThemeConstants.lightSubtitle, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                label: Text("email"),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 20),
                  child: EcoIcon(path: IconPaths.email),
                ),
              ),       
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 1.5)/100,),
            TextField(
              style: GoogleFonts.montserrat(fontSize: ThemeConstants.getDynamicFontSize(15), color: ThemeConstants.lightSubtitle, fontWeight: FontWeight.w500),
              obscureText: true,
              decoration: InputDecoration(
                label: Text("phone"),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 20),
                  child: EcoIcon(
                    path: IconPaths.phone,
                    size: ThemeConstants.screenHeight / 35,
                  ),
                ),
              ),
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 1.5)/100,),
            TextField(
              style: GoogleFonts.montserrat(fontSize: ThemeConstants.getDynamicFontSize(15), color: ThemeConstants.lightSubtitle, fontWeight: FontWeight.w500),
              obscureText: true,
              decoration: InputDecoration(
                label: Text("password"),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 20),
                  child: EcoIcon(
                    path: IconPaths.lock,
                    size: ThemeConstants.screenHeight / 35,
                    ),
                ),
              ),       
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 1.5)/100,),
            TextField(
              style: GoogleFonts.montserrat(fontSize: ThemeConstants.getDynamicFontSize(15), color: ThemeConstants.lightSubtitle, fontWeight: FontWeight.w500),
              obscureText: true,
              decoration: InputDecoration(
                label: Text("confirm password"),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 18.0, right: 20),
                  child: EcoIcon(path: IconPaths.lock2, size: ThemeConstants.screenHeight / 32,
                    ),
                ),
              ),       
            ),
            Expanded(child: SizedBox(),),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ElevatedButton(onPressed: () => Navigator.push(context, CupertinoPageRoute(builder: (_) => PinScreen())), child: Text("Next", style: GoogleFonts.montserrat(fontWeight: FontWeight.w500))),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:eco_return/core/utilitis/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/login/signUp/sign_up.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool visibility = false;

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
            SizedBox(height: (ThemeConstants.screenHeight * 8) / 100),
            Text(
              "Sign in to your eco-Return account",
              style: textTheme.bodyLarge,
            ),
            Text(
                "\nSign in to your eco-Return account to continue. If you do not have an account, tap the Sign Up button to create an account now!"),
            SizedBox(height: (ThemeConstants.screenHeight * 8) / 100),
            TextField(
              style: GoogleFonts.montserrat(
                  fontSize: ThemeConstants.getDynamicFontSize(15),
                  color: ThemeConstants.lightSubtitle,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                label: Text("email"),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 19.0, right: 20),
                  child: EcoIcon(
                    path: IconPaths.email,
                    size: ThemeConstants.iconSize,
                  ),
                ),
              ),
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 1.5) / 100),
            TextField(
              style: GoogleFonts.montserrat(
                  fontSize: ThemeConstants.getDynamicFontSize(15),
                  color: ThemeConstants.lightSubtitle,
                  fontWeight: FontWeight.w500),
              obscureText: visibility,
              decoration: InputDecoration(
                label: Text("password"),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: EcoIcon(
                    path: IconPaths.lock,
                    size: ThemeConstants.screenHeight / 35,
                  ),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility),
                  color: const Color.fromARGB(31, 0, 129, 90),
                  onPressed: () => setState(() {
                    visibility = !visibility;
                  }),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, CupertinoPageRoute(builder: (_) => SignUpMain())),
              child: Text(
                "Sign in",
                style: GoogleFonts.montserrat(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 20.0,
                top: 12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?"),
                  GestureDetector(
                    onTap: () => print("REGISTER!"),
                    child: Text(
                      " Register!",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        color: ThemeConstants.ecoGreen,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

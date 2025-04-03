import 'dart:io';

import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/core/base/controllers/photo_handler.dart';
import 'package:eco_return/root/components/login/kyc/dob_screen.dart';
import 'package:eco_return/root/components/login/signUp/pin_screen.dart';
import 'package:eco_return/root/widgets/otp_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({Key? key}) : super(key: key);

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> with SingleTickerProviderStateMixin {
  FocusNode focusNode = FocusNode();
  late AnimationController _controller;
  late Animation<double> _animation;
  File? _selectedImage;
  String? name;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(milliseconds: 700), () => focusNode.requestFocus());
    });
 

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 40),
    );

    _animation = Tween<double>(
      begin: ThemeConstants.screenHeight / 28, // Original size
      end: ThemeConstants.screenHeight / 30, // Shrink size
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    // Automatically reset the animation after completion
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 20), () {
          _controller.reverse();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resizeIcon() {
    if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () => print("SKIP"),
            child: const Padding(
              padding: EdgeInsets.only(top: 5.0, right: 25),
              child: Text("Skip"),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: (ThemeConstants.screenHeight * 7) / 100),
            Text("Hi", style: Theme.of(context).textTheme.bodyLarge),
            const Text(
              "\nWelcome to Eco-Return. Please enter your name and upload your photo with a smile!",
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 5) / 100),
            Center(
              child: Stack(
                children: [
                  _selectedImage == null
                    ? Image.asset(
                        "Assets/illustrations/default_profile.png",
                        height: ThemeConstants.screenHeight / 4,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(55),
                        child: Image.file(
                          _selectedImage!,
                          height: ThemeConstants.screenHeight / 4,
                        ),
                      ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap:() async { 
                        _resizeIcon();
                        print("PHOTO");
                        File? image = await PhotoHandler.pickImage(context);
                          if (image != null) {
                            setState(() {
                              _selectedImage = image;
                            });
                          }
                        },
                      child: AnimatedBuilder(
                        animation: _animation,
                        builder: (context, child) {
                          return Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                _selectedImage == null ? BoxShadow(
                                  color: const Color.fromARGB(255, 0, 116, 106).withOpacity(0.2), // Shadow color
                                  blurRadius: 6, // Spread of the shadow
                                  spreadRadius: 1,
                                  offset: Offset(0, -0), // Offset of the shadow
                                ) : BoxShadow(
                                  color: const Color.fromARGB(255, 0, 116, 106).withOpacity(0.5), // Shadow color
                                  blurRadius: 9, // Spread of the shadow
                                  spreadRadius: 2,
                                  offset: Offset(-2, -2), // Offset of the shadow
                                ),
                              ],
                            ),
                            height: _animation.value,
                            child: Image.asset(
                              "Assets/icons/camera.png",
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: (ThemeConstants.screenHeight * 3) / 100),
            TextField(
              focusNode: focusNode,
              controller: controller,
              keyboardType: TextInputType.name,
              onChanged: (value) => name = value,
              style: GoogleFonts.montserrat(
                fontSize: ThemeConstants.getDynamicFontSize(15),
                color: ThemeConstants.lightSubtitle,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                label: const Text("Name"),
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: SvgPicture.asset(
                    "Assets/icons/smile.svg",
                    height: ThemeConstants.screenHeight / 42,
                    colorFilter: ColorFilter.mode(
                      ThemeConstants.ecoGreen,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Text("\nYour name is required to continue.",
                style: GoogleFonts.montserrat(
                  color: Theme.of(context).colorScheme.primary.withAlpha(150),
                  fontSize: 12,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller,
                builder: (context, value, child) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.transparent,
                      side: BorderSide(
                        width: 3,
                        color: value.text.isNotEmpty
                            ? ThemeConstants.ecoGreen
                            : Colors.grey,
                      ),
                    ),
                    onPressed: name != null
                        ? () {
                          print("Verification Successful");
                          Navigator.push(context, CupertinoPageRoute(builder: (_) => DOBScreen()));
                        }
                        : null,
                    child: Text(
                      "Next",
                      style:
                          GoogleFonts.montserrat(fontWeight: FontWeight.w500),
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

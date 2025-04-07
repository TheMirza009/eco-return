import 'dart:io';
import 'package:eco_return/core/base/controllers/locale_controller.dart';
import 'package:eco_return/core/base/controllers/shared_pref_controller.dart';
import 'package:eco_return/core/collections/icon_paths.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/home/homescreen.dart';
import 'package:eco_return/root/components/login/sign_in.dart';
import 'package:eco_return/root/components/payment_methods/payment_method_screen.dart';
import 'package:eco_return/root/components/payment_methods/providers/payment_method_states.dart';
import 'package:eco_return/root/components/profile/language_selection_screen.dart';
import 'package:eco_return/root/data/models/settings_model.dart';
import 'package:eco_return/root/data/models/user_model.dart';
import 'package:eco_return/root/widgets/date_picker_tile.dart';
import 'package:eco_return/root/widgets/eco_icon.dart';
import 'package:eco_return/root/widgets/eco_list_tile.dart';
import 'package:eco_return/root/widgets/eco_textfield.dart';
import 'package:eco_return/root/widgets/payment_method_tile.dart';
import 'package:eco_return/root/widgets/profile_photo_widget.dart';
import 'package:eco_return/root/widgets/section_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  /// Declarations
  File? _selectedImage;
  bool notificationStatus = false;
  final screenHeight = ThemeConstants.screenHeight;
  ValueNotifier<bool> showTitle = ValueNotifier<bool>(false);
  ValueNotifier<bool> dataChanged = ValueNotifier<bool>(false);
  String primaryMethod = PaymentMethodStates.paymentMethods.isNotEmpty
      ? "****${PaymentMethodStates.paymentMethods[0].cardNumber.substring(PaymentMethodStates.paymentMethods[0].cardNumber.length - 4)}"
      : "None"; // Fallback value if the list is empty

  // String holders
  String? name;
  String? email;
  String? phoneNumber;
  String? address;
  DateTime dob = DateTime.now();

  Future<void> updateUserData() async {
    String languageCode = Localizations.localeOf(context).languageCode;

    // Riverpod Data update
    User userData = User(
      name: name,
      gender: "male", //? To correct using ENUMs Later
      email: email,
      address: address,
      phoneNumber: phoneNumber,
      dob: dob,
      settings: Settings(
        notifications: notificationStatus,
        languageCode: languageCode,
      ),
    );
    ref.read(userProvider.notifier).state = userData;
    final userDataJSON = await userData.toJson();
    await SharedPrefController.saveUserData(userDataJSON);
  }

  @override
  void initState() {
    super.initState();

    // This ensures that we wait until the widget's first build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeValues();
    });
  }

  initializeValues() {
    final userData = ref.read(userProvider);
    setState(() {
      name = userData.name!;
      email = userData.email!;
      phoneNumber = userData.phoneNumber!;
      address = userData.address!;
      dob = userData.dob!;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Locale for translations
    AppLocalizations locale = LocaleController.getLocale(context);
    final userData = ref.watch(userProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        toolbarHeight: 40,
        title: ValueListenableBuilder(
          valueListenable: showTitle,
          builder: (context, value, child) {
            return AnimatedOpacity(
              opacity: value ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Text(
                locale.profile,
                style: GoogleFonts.montserrat(
                  fontSize: screenHeight * 0.025,
                ),
              ),
            );
          },
        ),
        actions: [
          ValueListenableBuilder<bool>(
            valueListenable: dataChanged,
            builder: (context, value, _) {
              return AnimatedOpacity(
                opacity: value ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 100),
                child: TextButton(
                  onPressed: value
                      ? () async {
                          Future.delayed(Duration(milliseconds: 200),
                              () => dataChanged.value = false);
                          await updateUserData();
                        }
                      : null,
                  child: value
                      ? Text(
                          "Save",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              fontSize: screenHeight * 0.018,
                              color: ThemeConstants.ecoGreen),
                        )
                      : SizedBox.shrink(),
                ),
              );
            },
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.axis == Axis.vertical) {
            final scrolled = scrollInfo.metrics.pixels > screenHeight * 0.1;
            if (scrolled != showTitle.value) {
              showTitle.value = scrolled;
            }
          }
          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: ThemeConstants.screenHeight / 15),
                Center(
                  child: ProfilePhoto(
                    selectedImage: _selectedImage,
                    onImageSelected: (image) {
                      setState(() {
                        _selectedImage = image;
                        dataChanged.value = true;
                      });
                    },
                  ),
                ),
                SizedBox(height: ThemeConstants.screenHeight * 4 / 100),
                Transform.translate(
                  offset: Offset(-22, 0),
                  child: SectionLabel(label: locale.profile),
                ),
                SizedBox(height: ThemeConstants.screenHeight * 2 / 100),

                /// Name Field
                EcoTextField(
                  iconPath: IconPaths.smile,
                  initialValue: userData.name ?? "",
                  label: locale.name,
                  onChanged: (text) {
                    if (userData.name != text) {
                      dataChanged.value = true;
                      name = text.isEmpty
                          ? userData.name!
                          : text; // If the text is empty, revert to the initial value
                    }
                  },
                ),
                SizedBox(height: ThemeConstants.screenHeight * 2 / 100),

                /// Email Field
                EcoTextField(
                  iconPath: IconPaths.email,
                  initialValue: userData.email ?? "",
                  label: locale.email,
                  onChanged: (text) {
                    if (userData.email != text) {
                      dataChanged.value = true;
                      email = text.isEmpty
                          ? userData.email!
                          : text; // If the text is empty, revert to the initial value
                    }
                  },
                ),
                SizedBox(height: ThemeConstants.screenHeight * 2 / 100),

                /// Phone Field
                EcoTextField(
                  iconPath: IconPaths.phone,
                  initialValue: userData.phoneNumber ?? "",
                  label: locale.phone,
                  onChanged: (text) {
                    if (userData.phoneNumber != text) {
                      dataChanged.value = true;
                      phoneNumber = text.isEmpty
                          ? userData.phoneNumber!
                          : text; // If the text is empty, revert to the initial value
                    }
                  },
                ),
                SizedBox(height: ThemeConstants.screenHeight * 2 / 100),

                /// Address Field
                EcoTextField(
                  iconPath: IconPaths.home,
                  initialValue: userData.address ?? "",
                  label: locale.address,
                  onChanged: (text) {
                    if (userData.address != text) {
                      dataChanged.value = true;
                      address = text.isEmpty
                          ? userData.address!
                          : text; // If the text is empty, revert to the initial value
                    }
                  },
                ),

                SizedBox(height: ThemeConstants.screenHeight * 2 / 100),

                /// Date of Birth Field
                // EcoTextField(
                //   iconPath: IconPaths.cake,
                //   initialValue: "",
                //   label: "Date of Birth",
                //   onChanged: (text){},
                // ),
                DatePickerTile(
                    initialDate: userData.dob ?? DateTime.now(),
                    onDateSelected: (date) => dob = date ?? userData.dob!),
                SizedBox(height: ThemeConstants.screenHeight * 2 / 100),

                /// Payment Method Field
                // EcoTextField(
                //   iconPath: IconPaths.paymentMethod,
                //   initialValue: "",
                //   label: "Payment method",
                //   onChanged: (text){},
                // ),
                EcoListTile(
                  ecoIconPath: IconPaths.paymentMethod,
                  title: locale.paymentMethod,
                  backgroundColor: Colors.transparent,
                  borderColor: ThemeConstants.lightBorder,
                  borderWidth: 2,
                  trailingWidget: Text(
                    primaryMethod,
                    style: GoogleFonts.montserrat(
                      color: const Color.fromARGB(255, 19, 33, 43),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (_) => PaymentMethodScreen())),
                ),

                SizedBox(height: ThemeConstants.screenHeight * 4 / 100),
                Transform.translate(
                  offset: Offset(-22, 0),
                  child: SectionLabel(label: locale.settings),
                ),
                SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
                EcoListTile(
                  ecoIconPath: IconPaths.smile,
                  title: locale.language,
                  trailingWidget: Text(
                    LocaleController.getLanguageName(
                        Localizations.localeOf(context).languageCode),
                    style: GoogleFonts.montserrat(
                      color: const Color.fromARGB(255, 19, 33, 43),
                    ),
                  ),
                  onTap: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (_) => LanguageSelectionScreen())),
                ),
                SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
                EcoListTile(
                  ecoIconPath: IconPaths.clock,
                  title: locale.notifications,
                  trailingWidget: Text(
                    notificationStatus ? locale.on : locale.off,
                    style: GoogleFonts.montserrat(
                      color: const Color.fromARGB(255, 19, 33, 43),
                    ),
                  ),
                  onTap: () => setState(() {
                    notificationStatus = !notificationStatus;
                  }),
                ),
                SizedBox(height: ThemeConstants.screenHeight * 2 / 100),
                EcoListTile(
                  ecoIconPath: IconPaths.logout,
                  title: locale.logout,
                  onTap: () => showLogoutDialog(context),
                ),
                SizedBox(height: ThemeConstants.screenHeight / 4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showLogoutDialog(BuildContext context) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      // Locale for translations
      AppLocalizations locale = LocaleController.getLocale(context);

      // Dialogue
      return CupertinoAlertDialog(
        title: Text(
          locale.logout,
          style: GoogleFonts.montserrat(),
        ),
        content: Text(
          locale.sureLogout,
          style: GoogleFonts.montserrat(),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
            },
            child: Text(
              locale.cancel,
              style: GoogleFonts.montserrat(
                  fontSize: ThemeConstants.screenHeight * 1.7 / 100),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss the dialog
              Navigator.pushAndRemoveUntil(
                context,
                // CupertinoPageRoute(builder: (_) => HomeScreenBottomNav()),
                CupertinoPageRoute(builder: (_) => SignInScreen()),
                (route) => false,
              );
              print("User logged out");
            },
            isDestructiveAction: true, // Highlights the button in red
            child: Text(locale.logout,
                style: GoogleFonts.montserrat(
                    fontSize: ThemeConstants.screenHeight * 1.7 / 100)),
          ),
        ],
      );
    },
  );
}

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:eco_return/core/base/controllers/languages.dart';
import 'package:eco_return/core/base/controllers/locale_controller.dart';
import 'package:eco_return/core/theme/theme_constants.dart';
import 'package:eco_return/root/components/home/bottom_nav_screen.dart';
import 'package:eco_return/root/components/home/locale_test.dart';
import 'package:eco_return/root/components/login/kyc/payment_method_screen_kyc.dart';
import 'package:eco_return/root/components/login/sign_in.dart';
import 'package:eco_return/root/widgets/exit_toast.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeConstants.screenWidth = MediaQuery.sizeOf(context).width;
    ThemeConstants.screenHeight = MediaQuery.sizeOf(context).height;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Set your desired color
        statusBarIconBrightness:
            Brightness.light, // Set the icon color (light/dark)
      ),
    );

    final locale = ref.watch(localeProvider); // Watch locale changes

    return MaterialApp(
        title: 'Eco-Return',
        theme: ThemeConstants.lightTheme,
        locale: locale,
        supportedLocales: Languages.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        // localizationsDelegates: const [
        //   AppLocalizations.delegate, // Generated localization delegate
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        home: DoubleBack(
            message: "",
            background: Colors.transparent,
            onFirstBackPress: (context) => showDialog(
                  context: context,
                  barrierColor: Colors.transparent,
                  barrierDismissible: false,
                  builder: (BuildContext context) => const ExitToast(),
                ),
            child: const HomeScreenBottomNav()),
        // const HomeScreenBottomNav()),
        // home: const SignInScreen(),
        // home: const PaymentMethodKYC(),
        );
  }
}

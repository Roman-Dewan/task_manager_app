import 'package:flutter/material.dart';
import 'package:module18_19/ui/screens/add_new_task.dart';
import 'package:module18_19/ui/screens/forget_password_email.dart';
import 'package:module18_19/ui/screens/forget_password_otp_verification.dart';
import 'package:module18_19/ui/screens/main_bottom_nav_holder_screen.dart';
import 'package:module18_19/ui/screens/reset_password.dart';
import 'package:module18_19/ui/screens/sign_in_screen.dart';
import 'package:module18_19/ui/screens/sign_up_screen.dart';
import 'package:module18_19/ui/screens/splash_screen.dart';
import 'package:module18_19/ui/screens/update_profile.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,

        // TextFormField-->  theme
        inputDecorationTheme: InputDecorationTheme(
          fillColor: Colors.white,
          filled: true,
          hintStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
        ),

        // FilledButtonTheme --> theme
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: Colors.green[600],
            foregroundColor: Colors.white,
            fixedSize: Size.fromWidth(double.maxFinite),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // TextTHeme
        textTheme: TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.bold),
          labelLarge: TextStyle(color: Colors.grey),
          titleMedium: TextStyle(color: Colors.white),
          titleLarge: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),

        // scaffold color
        scaffoldBackgroundColor: Colors.green.shade50,
      ),

      routes: {
        SplashScreen.name: (context) => const SplashScreen(),
        SignInScreen.name: (context) => const SignInScreen(),
        SignUpScreen.name: (context) => const SignUpScreen(),
        ForgetPasswordEmail.name: (context) => const ForgetPasswordEmail(),
        OtpVerification.name: (context) => const OtpVerification(),
        ResetPassword.name: (context) => const ResetPassword(),
        MainBottomNav.name: (context) => const MainBottomNav(),
        AddNewTask.name: (context) => const AddNewTask(),
        UpdateProfile.name: (context) => const UpdateProfile(),
      },
      initialRoute: SplashScreen.name,

      home: SplashScreen(),
    );
  }
}

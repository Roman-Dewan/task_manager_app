import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manage_updated/ui/providers/new_task_list_provider.dart';
import 'package:task_manage_updated/ui/providers/sign_in_provider.dart';
import 'screens/add_new_task.dart';
import 'screens/forget_password_email.dart';
import 'screens/forget_password_otp_verification.dart';
import 'screens/main_bottom_nav_holder_screen.dart';
import 'screens/reset_password.dart';
import 'screens/sign_in_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/update_profile.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> SignInProvider()),
        ChangeNotifierProvider(create: (context)=> NewTaskListProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
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
        debugShowCheckedModeBanner: false,
      
        home: SplashScreen(),
      ),
    );
  }
}
